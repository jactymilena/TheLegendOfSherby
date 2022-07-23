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
            clk : in std_ulogic;
            pixel_X : in STD_LOGIC_VECTOR (3 downto 0);
            pixel_Y : in STD_LOGIC_VECTOR (3 downto 0);
            tileId : in STD_LOGIC_VECTOR (7 downto 0);
           colorCode : out STD_ULOGIC_VECTOR (3 downto 0));
           
end tileBgBuffer;

architecture Behavioral of tileBgBuffer is
--type Tuiles256 is array(0 to 255) of std_logic_vector(1023 downto 0);

type tableauCouleur is array (0 to 255) of std_ulogic_vector(3 downto 0);
type TuilesTableau is array(0 to 255) of tableauCouleur;

--signal tabcc : ccTile;
--signal remplirCC, tuileCC : STD_LOGIC_VECTOR (1023 downto 0);

signal bufferTmp : tableauCouleur;
signal TuilesBuffer : TuilesTableau := (
   (others=> x"0"),
   (others=> NOIR_CC), -- tuile 1  
   (others=> BLANC_CC),--  tuile 2         
   (others=> BLEU1_CC), -- eau bleu pale tuile 3       
   (others=> ROUGE_CC), -- rouge tuile 4               
   (others=> ROSE_CC), -- rose  tuile 5              
   (others=> BEIGE_CC), -- beige tuile 6               
   (others=> LIME_CC), -- Lime tuile 7                
   (others=> VERT1_CC), -- vert buisson tuile 8   
   (others=> VERT2_CC), -- vert foret     tuile 9  
   (others=> BRUN_CC), -- Brun tuile 10
   (others=> ORANGE_CC),-- orange tuile 11
   (others=> JAUNE_CC), -- tuile 12       
   (others=> GRIS_CC), -- Gris tuile 13           
   (others=> BLEU2_CC), -- Bleu foncé tuile 14     
   (others => x"f"),    --tuile 15       
   (BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,BLANC_CC,  BLANC_CC, BLANC_CC, BLANC_CC,BLANC_CC,BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,
    BLANC_CC,NOIR_CC,NOIR_CC, NOIR_CC, BLANC_CC,  BLANC_CC, BLANC_CC, BLANC_CC,BLANC_CC,BLANC_CC, BLANC_CC, BLANC_CC, NOIR_CC, NOIR_CC,NOIR_CC, BLANC_CC,
    BLANC_CC,NOIR_CC,NOIR_CC, NOIR_CC, NOIR_CC,   BLANC_CC, BLANC_CC, BLANC_CC,BLANC_CC,BLANC_CC, BLANC_CC, NOIR_CC,  NOIR_CC, NOIR_CC,NOIR_CC, BLANC_CC,
    BLANC_CC,NOIR_CC,NOIR_CC, NOIR_CC, NOIR_CC,   NOIR_CC,  BLANC_CC, BLANC_CC,BLANC_CC,BLANC_CC, NOIR_CC,  NOIR_CC,  NOIR_CC, NOIR_CC,NOIR_CC, BLANC_CC,
    BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC, NOIR_CC,  NOIR_CC,  NOIR_CC,  BLANC_CC,BLANC_CC,NOIR_CC,  NOIR_CC,  NOIR_CC,  BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,
    BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC, BLANC_CC, NOIR_CC,  NOIR_CC,  NOIR_CC, NOIR_CC, NOIR_CC,  NOIR_CC,  BLANC_CC, BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,
    BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC, BLANC_CC, BLANC_CC, NOIR_CC,  NOIR_CC, NOIR_CC, NOIR_CC,  BLANC_CC, BLANC_CC, BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,
    BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC, NOIR_CC, NOIR_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,
    BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,BLANC_CC,BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,
    BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,BLANC_CC,BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,
    BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,BLANC_CC,BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,
    BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,BLANC_CC,BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,
    BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,BLANC_CC,BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,
    BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,BLANC_CC,BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,
    BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,BLANC_CC,BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,
    BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,BLANC_CC,BLANC_CC, BLANC_CC, BLANC_CC, BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC  ),-- M pour menu tuile 16

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
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"), -- Y pour play tuile 17
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
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"), -- P pour play tuile 18

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
	, x"1", x"1", x"1", x"1", x"1", ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, x"1", x"1", x"1"), -- L POUR PLAY TUILE 19

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

(BLANC_CC,NOIR_CC,NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC,  
     BLANC_CC,NOIR_CC,NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC,  
     BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,
     BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,
     BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,
     BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,
     BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,
     BLANC_CC,NOIR_CC,NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, BLANC_CC,
     BLANC_CC,NOIR_CC,NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, BLANC_CC,
     BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,
     BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,
     BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,
     BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,
     BLANC_CC,NOIR_CC,NOIR_CC, BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,BLANC_CC,
     BLANC_CC,NOIR_CC,NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC,  
     BLANC_CC,NOIR_CC,NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC, NOIR_CC),--E tuile 18

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
	, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC, BRUN_CC), -- Brick tuile 19
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
	, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC, VERT2_CC), -- Bush tuile 20
	
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
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"), -- coffre tuile 21
	
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
	, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, BEIGE_CC, BEIGE_CC, BEIGE_CC, BRUN_CC, BRUN_CC, BEIGE_CC, BRUN_CC, ORANGE_CC, ORANGE_CC, BRUN_CC, BEIGE_CC, GRIS_CC), -- dirt tuile 22
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
	, x"2", GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, GRIS_CC, x"1", GRIS_CC, GRIS_CC, x"1", GRIS_CC, x"2", x"2"), -- rocks tuile 23
	
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
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"), -- stone wall tuile 24
	
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
	, x"2", x"2", x"2", x"2", x"2", x"2", x"2", x"2", x"2", x"2", x"2", BLEU1_CC, BLEU1_CC, BLEU1_CC, x"2", x"2"), -- water tuile 25
	
others =>  (others => x"0")
);


begin

process(tileId, pixel_Y, pixel_X)
    begin
--        if clk='1' and clk'event then

        bufferTmp <= TuilesBuffer(to_integer(unsigned(tileId)));
        colorCode <= bufferTmp((to_integer((unsigned(pixel_Y) * 16) + (unsigned(pixel_X)))));
--        end if;
 end process;

end Behavioral;
