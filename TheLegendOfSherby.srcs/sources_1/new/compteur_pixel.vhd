----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/21/2022 03:18:00 PM
-- Design Name: 
-- Module Name: compteur_pixel - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity compteur_pixel is
    Port ( i_reset : in STD_LOGIC;
           i_enable : in STD_LOGIC;
           i_clk : in STD_LOGIC;
           i_setActorX : in STD_LOGIC_VECTOR (8 downto 0);
           i_setActorY : in STD_LOGIC_VECTOR (8 downto 0);
           i_ActorId : in STD_LOGIC_VECTOR (3 downto 0);
           o_PositionX : out STD_LOGIC_VECTOR (8 downto 0);
           o_PositionY : out STD_LOGIC_VECTOR (8 downto 0));
end compteur_pixel;

architecture Behavioral of compteur_pixel is
--signaux
signal clk224, en224, rst224, clk256, en256, rst256: std_logic;
signal offsetx, offsety, val_cpt224, val_cpt256: std_logic_vector(8 downto 0);

--component
component MEF_cpt_pix is
    Port ( i_rst : in STD_LOGIC;
           i_en : in STD_LOGIC;
           i_clk : in STD_LOGIC;
           i_OffsetX : in STD_LOGIC_VECTOR (8 downto 0);
           i_OffsetY : in STD_LOGIC_VECTOR (8 downto 0);
           i_cpt256 : in STD_LOGIC_VECTOR (8 downto 0);
           i_cpt224 : in STD_LOGIC_VECTOR (8 downto 0);
           o_en256 : out STD_LOGIC;
           o_en224 : out STD_LOGIC;
           o_rst256 : out STD_LOGIC;
           o_rst224 : out STD_LOGIC;
           o_PositionX : out STD_LOGIC_VECTOR (8 downto 0);
           o_PositionY : out STD_LOGIC_VECTOR (8 downto 0));
end component MEF_cpt_pix;

component compteur_nbits is
generic (nbits : integer := 8);
   port ( clk             : in    std_logic; 
          i_en            : in    std_logic; 
          reset           : in    std_logic; 
          o_val_cpt       : out   std_logic_vector (nbits-1 downto 0)
          );
end component compteur_nbits;

component ScrollX is
    Port ( i_SetActorX : in STD_LOGIC_VECTOR (8 downto 0);
           i_clk: in STD_LOGIC;
           i_en: in STD_LOGIC;
           ActorId : in STD_LOGIC_VECTOR (3 downto 0);
           o_OffsetX : out STD_LOGIC_VECTOR (8 downto 0));
end component ScrollX;

begin

inst_cpt224: compteur_nbits
    port map(
        clk    => clk224,   
        i_en   => en224,
        reset  => rst224,
        o_val_cpt  => val_cpt224
    );

inst_cpt256: compteur_nbits
    port map(
        clk    => clk256,   
        i_en   => en256,
        reset  => rst256,
        o_val_cpt  => val_cpt256
    );
    
inst_MEF:MEF_cpt_pix 
    Port map(
           i_rst => i_reset,
           i_en => i_enable,
           i_clk => i_clk,
           i_OffsetX => offsetx,
           i_OffsetY => offsety,
           i_cpt256 => val_cpt256,
           i_cpt224 => val_cpt224,
           o_en256 => en256,
           o_en224 => en224,
           o_rst256 => rst256,
           o_rst224 => rst224,
           o_PositionX => o_PositionX,
           o_PositionY => o_PositionY
    ); 


end Behavioral;
