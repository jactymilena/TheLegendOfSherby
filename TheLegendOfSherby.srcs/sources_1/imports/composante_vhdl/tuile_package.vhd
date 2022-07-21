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
--  Port ( );
type ccTile is array(0 to 255) of std_ulogic_vector(3 downto 0);
type RegistreTileId is array(0 to 32, 0 to 32) of std_ulogic_vector(7 downto 0);
end package;

package body tuile_package is


end package body tuile_package;
