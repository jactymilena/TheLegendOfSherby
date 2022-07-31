----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.07.2022 17:08:25
-- Design Name: 
-- Module Name: tuile_package - package
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

package tuile_package is
-- constant _CC   : std_ulogic_vector( 3 downto 0 ) := X"0"; 
 constant TRANS_CC  : std_ulogic_vector( 3 downto 0 ) := X"0"; 
 constant NOIR_CC   : std_ulogic_vector( 3 downto 0 ) := "0001";
 constant BLANC_CC  : std_ulogic_vector( 3 downto 0 ) := X"2";
 constant BLEU1_CC  : std_ulogic_vector( 3 downto 0 ) := X"3";
 constant ROUGE_CC  : std_ulogic_vector( 3 downto 0 ) := X"4";
 constant ROSE_CC   : std_ulogic_vector( 3 downto 0 ) := X"5";
 constant BEIGE_CC  : std_ulogic_vector( 3 downto 0 ) := X"6";
 constant LIME_CC   : std_ulogic_vector( 3 downto 0 ) := X"7";
 constant VERT1_CC  : std_ulogic_vector( 3 downto 0 ) := X"8";
 constant VERT2_CC  : std_ulogic_vector( 3 downto 0 ) := X"9";
 constant BRUN_CC   : std_ulogic_vector( 3 downto 0 ) := X"a";
 constant ORANGE_CC : std_ulogic_vector( 3 downto 0 ) := X"b";
 constant JAUNE_CC  : std_ulogic_vector( 3 downto 0 ) := X"c";
 constant GRIS_CC   : std_ulogic_vector( 3 downto 0 ) := X"d";
 constant BLEU2_CC  : std_ulogic_vector( 3 downto 0 ) := X"e";
 -- constant _CC   : std_ulogic_vector( 3 downto 0 ) := X"f"; 

type ccTile is array(0 to 255) of std_ulogic_vector(3 downto 0);
type RegistreTileId is array(0 to 32, 0 to 32) of std_logic_vector(7 downto 0);


type tableauCouleur is array (0 to 255) of std_ulogic_vector(3 downto 0);
type tableauTileid is array (0 to 11) of std_logic_vector(7 downto 0);
type tableau_4       is array (0 to 11) of std_logic_vector(3 downto 0);
type tableau_1       is array (0 to 11) of std_logic;
type TuilesTableau is array(0 to 255) of tableauCouleur;

end package;

package body tuile_package is


end package body tuile_package;
