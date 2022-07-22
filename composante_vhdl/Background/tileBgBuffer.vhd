----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.07.2022 12:14:45
-- Design Name: 
-- Module Name: tileBgBuffer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.tuile_package.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tileBgBuffer is
    Port ( 
--            clk : in std_ulogic;
            pixel_X : in STD_LOGIC_VECTOR (3 downto 0);
            pixel_Y : in STD_LOGIC_VECTOR (3 downto 0);
            tileId : in STD_LOGIC_VECTOR (7 downto 0);
           colorCode : out STD_ULOGIC_VECTOR (3 downto 0));
           
end tileBgBuffer;

architecture Behavioral of tileBgBuffer is
type Tuiles256 is array(0 to 255) of std_logic_vector(1023 downto 0);

type tableauCouleur is array (0 to 255) of std_ulogic_vector(3 downto 0);
type TuilesTableau is array(0 to 255) of tableauCouleur;

--signal tabcc : ccTile;
signal remplirCC, tuileCC : STD_LOGIC_VECTOR (1023 downto 0);
--component tile is
--    Port ( 
--            pixel_X : in STD_LOGIC_VECTOR (3 downto 0);
--            pixel_Y : in STD_LOGIC_VECTOR (3 downto 0);
--            tileId : in STD_LOGIC_VECTOR (7 downto 0);
--           RE : in std_logic ;    
--           inColorCode: in STD_LOGIC_VECTOR (63 downto 0);
--           outColorCode : out STD_LOGIC_VECTOR (3 downto 0));
--end component;


--signal TuilesMemory : Tuiles256 := (
---- 256 tuiles de background
--X"9999999999999999", -- gazon vert buisson tuile 0
--X"cccccccccccccccc",-- chemin jaune tuile 1
--X"3333333333333333", -- eau bleu pale tuile 2
--X"4444444444444444", -- rouge tuile 3
--X"5555555555555555", -- rose  tuile 4
--X"6666666666666666", -- beige tuile 5
--X"7777777777777777", -- Lime tuile 6
--X"8888888888888888", -- vert foret tuile 7
--X"aaaaaaaaaaaaaaaa", -- Brun tuile 8
--X"dddddddddddddddd", -- Gris tuile 9
--X"eeeeeeeeeeeeeeee", -- Bleu foncé tuile 10
--X"1111111111111111", -- noir tuile 11
--X"2222222222222222", -- blanc tuile 12
--X"", -- M pour menu tuile 13


--others => X"000000000000000");

signal bufferTmp : tableauCouleur;
signal TuilesBuffer : TuilesTableau := (
   (others=> VERT1_CC), -- gazon vert buisson tuile 0  
   (others=> JAUNE_CC),-- chemin jaune tuile 1         
   (others=> BLEU1_CC), -- eau bleu pale tuile 2       
   (others=> ROUGE_CC), -- rouge tuile 3               
   (others=> ROSE_CC), -- rose  tuile 4               
   (others=> BEIGE_CC), -- beige tuile 5               
   (others=> LIME_CC), -- Lime tuile 6                
   (others=> VERT2_CC), -- vert foret tuile 7          
   (others=> BRUN_CC), -- Brun tuile 8                
   (others=> GRIS_CC), -- Gris tuile 9                
   (others=> BLEU2_CC), -- Bleu foncé tuile 10         
   (others=> x"1"), -- noir tuile 11               
   (others=> x"2"), -- blanc tuile 12              
   (x"2", x"1", x"1", x"2", x"2", x"2", x"2", x"2",x"2",x"2", x"2", x"2", x"2", x"1", x"1", x"2",
    x"2", x"1", x"1", x"1", x"2", x"2", x"2", x"2",x"2",x"2", x"2", x"2", x"1", x"1", x"1", x"2",
    x"2", x"1", x"1", x"1", x"1", x"2", x"2", x"2",x"2",x"2", x"2", x"1", x"1", x"1", x"1", x"2",
    x"2", x"1", x"1", x"1", x"1", x"1", x"2", x"2",x"2",x"2", x"1", x"1", x"1", x"1", x"1", x"2",
    x"2", x"1", x"1", x"2", x"1", x"1", x"1", x"2",x"2",x"1", x"1", x"1", x"2", x"1", x"1", x"2",
    x"2", x"1", x"1", x"2", x"2", x"1", x"1", NOIR_CC,NOIR_CC,x"1", x"1", x"2", x"2", x"1", x"1", x"2",
    x"2", x"1", x"1", x"2", x"2", x"2", x"1", NOIR_CC,NOIR_CC,x"1", x"2", x"2", x"2", x"1", x"1", x"2",
    x"2", x"1", x"1", x"2", x"2", x"2", x"2", NOIR_CC,NOIR_CC,x"2", x"2", x"2", x"2", x"1", x"1", x"2",
    x"2", x"1", x"1", x"2", x"2", x"2", x"2", x"2",x"2",x"2", x"2", x"2", x"2", x"1", x"1", x"2",
    x"2", x"1", x"1", x"2", x"2", x"2", x"2", x"2",x"2",x"2", x"2", x"2", x"2", x"1", x"1", x"2",
    x"2", x"1", x"1", x"2", x"2", x"2", x"2", x"2",x"2",x"2", x"2", x"2", x"2", x"1", x"1", x"2",
    x"2", x"1", x"1", x"2", x"2", x"2", x"2", x"2",x"2",x"2", x"2", x"2", x"2", x"1", x"1", x"2",
    x"2", x"1", x"1", x"2", x"2", x"2", x"2", x"2",x"2",x"2", x"2", x"2", x"2", x"1", x"1", x"2",
    x"2", x"1", x"1", x"2", x"2", x"2", x"2", x"2",x"2",x"2", x"2", x"2", x"2", x"1", x"1", x"2",
    x"2", x"1", x"1", x"2", x"2", x"2", x"2", x"2",x"2",x"2", x"2", x"2", x"2", x"1", x"1", x"2",
    x"2", x"1", x"1", x"2", x"2", x"2", x"2", x"2",x"2",x"2", x"2", x"2", x"2", x"1", x"1", x"2"  ),-- M pour menu tuile 13,
	(x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"), -- Y pour play tuile 14
	(x"1", x"1", x"1", x"1", x"1", ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, ROUGE_CC, x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, ROUGE_CC, x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"), -- P pour play tuile 15
	(x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, x"1", x"1", x"1"), -- L POUR PLAY TUILE 16
	(x"1", x"1", x"1", x"1", ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1"), -- A pour play tuile 17
	(BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC
	, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, BEIGE_CC, BRUN_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, BEIGE_CC, BRUN_CC, ORANGE_CC, ORANGE_CC
	, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, BRUN_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC
	, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, BRUN_CC, BRUN_CC, BRUN_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC
	, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC
	, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC
	, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, BEIGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, BEIGE_CC, BRUN_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, BEIGE_CC
	, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, BEIGE_CC, BRUN_CC, ORANGE_CC, ORANGE_CC, BEIGE_CC, ORANGE_CC
	, ORANGE_CC, ORANGE_CC, BEIGE_CC, BRUN_CC, BRUN_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, BEIGE_CC, BRUN_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC
	, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, BRUN_CC, BRUN_CC, BRUN_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC
	, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC
	, BEIGE_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC
	, ORANGE_CC, ORANGE_CC, BEIGE_CC, BRUN_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, BEIGE_CC, BRUN_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC
	, ORANGE_CC, ORANGE_CC, ORANGE_CC, BRUN_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC
	, BEIGE_CC, ORANGE_CC, BRUN_CC, BRUN_CC, BRUN_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, ORANGE_CC, BEIGE_CC, BEIGE_CC, BRUN_CC, ORANGE_CC
	, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC), -- Brick tuile 18
	(VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC
	, VERT2_CC, x"1", x"1", VERT2_CC, x"1", x"1", x"1", VERT2_CC, x"1", x"1", x"1", x"1", VERT2_CC, x"1", x"1", VERT2_CC
	, VERT2_CC, VERT2_CC, x"1", x"1", x"1", x"1", x"1", VERT2_CC, VERT2_CC, VERT2_CC, x"1", x"1", VERT2_CC, x"1", x"1", VERT2_CC
	, VERT2_CC, VERT2_CC, VERT2_CC, x"1", x"1", x"1", VERT2_CC, x"1", x"1", VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, x"1", x"1", VERT2_CC
	, VERT2_CC, x"1", VERT2_CC, x"1", x"1", x"1", VERT2_CC, x"1", x"1", VERT2_CC, x"1", x"1", x"1", x"1", x"1", VERT2_CC
	, VERT2_CC, VERT2_CC, VERT2_CC, x"1", x"1", VERT2_CC, VERT2_CC, x"1", x"1", VERT2_CC, x"1", x"1", x"1", x"1", VERT2_CC, VERT2_CC
	, VERT2_CC, VERT2_CC, x"1", x"1", x"1", VERT2_CC, x"1", x"1", x"1", VERT2_CC, x"1", x"1", x"1", x"1", VERT2_CC, VERT2_CC
	, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, x"1", x"1", x"1", VERT2_CC, VERT2_CC, x"1", x"1", x"1", x"1", VERT2_CC, VERT2_CC
	, VERT2_CC, x"1", x"1", x"1", VERT2_CC, VERT2_CC, x"1", VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, x"1", x"1", VERT2_CC, VERT2_CC
	, VERT2_CC, x"1", x"1", x"1", x"1", VERT2_CC, VERT2_CC, x"1", x"1", x"1", VERT2_CC, x"1", VERT2_CC, x"1", VERT2_CC, VERT2_CC
	, VERT2_CC, x"1", VERT2_CC, x"1", VERT2_CC, VERT2_CC, x"1", x"1", x"1", x"1", VERT2_CC, x"1", VERT2_CC, x"1", VERT2_CC, VERT2_CC
	, VERT2_CC, x"1", VERT2_CC, x"1", VERT2_CC, x"1", x"1", x"1", x"1", VERT2_CC, x"1", x"1", VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC
	, VERT2_CC, VERT2_CC, VERT2_CC, x"1", VERT2_CC, x"1", x"1", x"1", VERT2_CC, VERT2_CC, x"1", x"1", x"1", x"1", VERT2_CC, VERT2_CC
	, VERT2_CC, VERT2_CC, x"1", x"1", VERT2_CC, x"1", x"1", VERT2_CC, VERT2_CC, x"1", x"1", x"1", x"1", x"1", x"1", VERT2_CC
	, VERT2_CC, VERT2_CC, VERT2_CC, x"1", VERT2_CC, x"1", x"1", VERT2_CC, x"1", x"1", x"1", x"1", x"1", x"1", VERT2_CC, VERT2_CC
	, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC), -- Bush tuile 19
	(x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, x"1", x"1", JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, JAUNE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", JAUNE_CC, JAUNE_CC, x"1"
	, x"1", JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"), -- coffre tuile 20
	(BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BRUN_CC, ORANGE_CC, GRIS_CC, BEIGE_CC, BRUN_CC, BEIGE_CC, BRUN_CC
	, BRUN_CC, BEIGE_CC, GRIS_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BRUN_CC, GRIS_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BEIGE_CC, ORANGE_CC, BRUN_CC
	, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BEIGE_CC, ORANGE_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC
	, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BRUN_CC, BEIGE_CC, GRIS_CC, BRUN_CC, BRUN_CC, BRUN_CC
	, BEIGE_CC, ORANGE_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, GRIS_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BEIGE_CC
	, BEIGE_CC, GRIS_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BEIGE_CC, BRUN_CC, GRIS_CC, BEIGE_CC, BRUN_CC
	, BRUN_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BEIGE_CC, ORANGE_CC, BRUN_CC
	, BRUN_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BEIGE_CC, GRIS_CC, BRUN_CC, BRUN_CC, BRUN_CC, ORANGE_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BEIGE_CC
	, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BEIGE_CC, GRIS_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BRUN_CC
	, BRUN_CC, BRUN_CC, BEIGE_CC, GRIS_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, ORANGE_CC, BEIGE_CC, BEIGE_CC, BRUN_CC, BEIGE_CC
	, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, ORANGE_CC, BRUN_CC, BEIGE_CC, GRIS_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BEIGE_CC, GRIS_CC, BEIGE_CC, ORANGE_CC
	, BRUN_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC
	, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC
	, BEIGE_CC, BRUN_CC, ORANGE_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, GRIS_CC, BRUN_CC, BRUN_CC, BEIGE_CC, ORANGE_CC
	, BRUN_CC, BEIGE_CC, GRIS_CC, BRUN_CC, BRUN_CC, BRUN_CC, GRIS_CC, BEIGE_CC, BRUN_CC, GRIS_CC, BEIGE_CC, BEIGE_CC, GRIS_CC, BRUN_CC, BEIGE_CC, BRUN_CC
	, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, ORANGE_CC, ORANGE_CC, BRUN_CC, BEIGE_CC, GRIS_CC), -- dirt tuile 21
	(x"2", GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"1", x"1", GRIS_CC, GRIS_CC, x"2", x"2", x"2", x"2", GRIS_CC, x"1", x"2"
	, x"1", x"1", x"1", x"1", x"2", x"2", x"2", x"1", GRIS_CC, GRIS_CC, GRIS_CC, x"2", GRIS_CC, x"1", x"1", x"2"
	, x"2", x"2", x"2", GRIS_CC, GRIS_CC, x"2", GRIS_CC, GRIS_CC, x"1", x"1", x"1", GRIS_CC, GRIS_CC, x"1", GRIS_CC, GRIS_CC
	, x"2", x"2", x"2", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"2", GRIS_CC, x"1", x"1", GRIS_CC, GRIS_CC, GRIS_CC
	, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"2", x"2", x"2", GRIS_CC, GRIS_CC, x"1", GRIS_CC, GRIS_CC
	, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", GRIS_CC, GRIS_CC, x"2", GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"1", x"1"
	, GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"1", x"1", x"1", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"1", GRIS_CC
	, x"1", x"1", x"1", x"1", GRIS_CC, GRIS_CC, x"2", x"1", x"1", x"1", GRIS_CC, GRIS_CC, x"1", x"1", x"2", GRIS_CC
	, GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"1", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"1", GRIS_CC, x"2", x"2", GRIS_CC
	, x"2", GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"1", x"1", GRIS_CC, x"2", x"1", x"1", x"1", x"1", GRIS_CC, GRIS_CC, GRIS_CC
	, x"2", x"2", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", GRIS_CC, x"1", x"1", GRIS_CC, GRIS_CC, x"1", x"1", GRIS_CC, GRIS_CC
	, x"2", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"1", x"1", x"2", x"2", GRIS_CC, GRIS_CC, x"1", x"1", GRIS_CC
	, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"1", GRIS_CC, x"2", x"2", GRIS_CC, GRIS_CC, x"1", x"1", x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"1", GRIS_CC, x"1"
	, x"2", x"2", x"2", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"1", GRIS_CC, GRIS_CC, GRIS_CC, x"1", GRIS_CC, GRIS_CC, x"2"
	, x"2", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", GRIS_CC, GRIS_CC, x"1", GRIS_CC, x"2", x"2"), -- rocks tuile 22
	(GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"2", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"2", GRIS_CC, GRIS_CC, GRIS_CC
	, GRIS_CC, x"2", GRIS_CC, x"1", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", GRIS_CC, GRIS_CC, x"2", GRIS_CC
	, x"2", GRIS_CC, GRIS_CC, x"1", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"2", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"2", x"1", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1"
	, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"2", GRIS_CC, x"1", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"2", GRIS_CC, GRIS_CC, x"1"
	, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"2", GRIS_CC, GRIS_CC, x"1", GRIS_CC, GRIS_CC, GRIS_CC, x"2", GRIS_CC, GRIS_CC, GRIS_CC, x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"2", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"2", GRIS_CC, GRIS_CC, GRIS_CC
	, GRIS_CC, GRIS_CC, GRIS_CC, x"1", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"2", GRIS_CC, GRIS_CC, x"1", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC
	, GRIS_CC, GRIS_CC, GRIS_CC, x"1", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"2", GRIS_CC, x"1", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"2", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", x"2", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1"
	, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"2", GRIS_CC, GRIS_CC, x"1", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1"
	, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"2", x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"), -- stone wall tuile 23
	(BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC
	, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC
	, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, x"2", x"2", x"2", x"2", BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC
	, x"2", x"2", x"2", x"2", x"2", BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, x"2", x"2", x"2", x"2", x"2", x"2", x"2"
	, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC
	, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC
	, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, x"2", x"2", x"2", x"2", BLEU1_CC, BLEU1_CC, BLEU1_CC
	, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC
	, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC
	, BLEU1_CC, BLEU1_CC, BLEU1_CC, x"2", x"2", x"2", x"2", x"2", x"2", x"2", BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC
	, x"2", x"2", x"2", BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, x"2", x"2", x"2", x"2", x"2", x"2"
	, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC
	, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC
	, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC
	, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, BLEU1_CC, x"2", x"2", x"2", BLEU1_CC, BLEU1_CC
	, x"2", x"2", x"2", x"2", x"2", x"2", x"2", x"2", x"2", x"2", x"2", BLEU1_CC, BLEU1_CC, BLEU1_CC, x"2", x"2"), -- water tuile 24
	others =>  (others => x"0")
);


begin

--process( clk )
--    begin
--        if clk='1' and clk'event then

        bufferTmp <= TuilesBuffer(to_integer(unsigned(tileId)));
        colorCode <= bufferTmp((to_integer((unsigned(pixel_Y) * 16) + (unsigned(pixel_X)))));
        
--        tuileCC <= TuilesMemory(to_integer(unsigned(tileId)));
--        colorCode <= tuileCC((to_integer((unsigned(pixel_Y) *64) + (unsigned(pixel_X)*4))+3) downto to_integer((unsigned(pixel_Y) *64)+ (unsigned(pixel_X)*4)));
--        end if;

--end process; 
--tile0: tile  Port map (
----pixel_X => pixel_X,
----pixel_Y => pixel_Y,
--tileId => X"00"
----inColorCode => remplirCC,
----outColorCode => colorCode
--);

end Behavioral;
