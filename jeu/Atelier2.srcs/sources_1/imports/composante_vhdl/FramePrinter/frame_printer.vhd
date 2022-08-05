----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2022 03:34:06 PM
-- Design Name: 
-- Module Name: frame_printer - Behavioral
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

entity frame_printer is
    Port ( PositionX : in STD_LOGIC_VECTOR (8 downto 0);
           PositionY : in STD_LOGIC_VECTOR (8 downto 0);
           i_clk: in STD_LOGIC;
           i_rst: in STD_LOGIC;
           i_en: in STD_LOGIC;
           control : out STD_LOGIC_VECTOR (3 downto 0));
end frame_printer;

architecture Behavioral of frame_printer is
--signaux
signal clk224, en224, rst224, clk256, en256, rst256: std_logic;
signal val_cpt224, val_cpt256: std_logic_vector(8 downto 0);

--component
component MEF_fp is
    Port ( i_x : in STD_LOGIC_VECTOR (8 downto 0);
           i_y : in STD_LOGIC_VECTOR (8 downto 0);
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           i_cpt224 : in STD_LOGIC_VECTOR (8 downto 0);
           i_cpt256 : in STD_LOGIC_VECTOR (8 downto 0);
           o_en224 : out STD_LOGIC;
           o_rst224 : out STD_LOGIC;
           o_en256 : out STD_LOGIC;
           o_rst256 : out STD_LOGIC;
           o_control : out STD_LOGIC_VECTOR (3 downto 0));
end component MEF_fp;

component compteur_nbits is
generic (nbits : integer := 8);
   port ( clk             : in    std_logic; 
          i_en            : in    std_logic; 
          reset           : in    std_logic; 
          o_val_cpt       : out   std_logic_vector (nbits-1 downto 0)
          );
end component compteur_nbits;

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
    
inst_MEF:MEF_fp 
    Port map( 
           i_x => PositionX,
           i_y => PositionY,
           clk => i_clk,
           reset => i_rst,
           enable => i_en,
           i_cpt224 => val_cpt224,
           i_cpt256 => val_cpt256,
           o_en224 => en224,
           o_rst224 => rst224,
           o_en256 => en256,
           o_rst256 => rst256,
           o_control => control
    ); 

end Behavioral;
