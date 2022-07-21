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
use IEEE.STD_LOGIC_UNSIGNED.ALL;  -- pour les additions dans les compteurs

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity compteur_nbits is
generic (nbits : integer := 8);
   port ( clk             : in    std_logic; 
          i_en            : in    std_logic; 
          reset           : in    std_logic; 
          o_val_cpt       : out   std_logic_vector (nbits-1 downto 0)
          );
end compteur_nbits;

architecture BEHAVIORAL of compteur_nbits is               
-- compteur simple

signal  d_val_cpt: std_logic_vector (nbits-1 downto 0);

BEGIN

compteur_proc : process (clk, reset, i_en)
   begin
      if ( reset = '1') then
          d_val_cpt <= (others =>'0');
      else
      if (rising_edge(clk) AND i_en = '1') then
          d_val_cpt <= d_val_cpt + 1;
      end if;
      end if;
   end process;
-- sortie
  o_val_cpt <= d_val_cpt;
  
 END Behavioral;
  
