----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.07.2022 11:22:45
-- Design Name: 
-- Module Name: comparateurBackground - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparateurBackground is
    Port ( GlobalX : in STD_LOGIC_VECTOR (8 downto 0);
           GlobalY : in STD_LOGIC_VECTOR (8 downto 0);
           PositionX0 : out STD_LOGIC_VECTOR (4 downto 0);
           PositionY0 : out STD_LOGIC_VECTOR (4 downto 0);
           posPixelX  : out STD_LOGIC_VECTOR (3 downto 0);
           posPixelY  : out STD_LOGIC_VECTOR (3 downto 0));
end comparateurBackground;

architecture Behavioral of comparateurBackground is
--signal debutX: std_logic_vector(8 downto 0);

begin

PositionX0 <= GlobalX(8 downto 4);
posPixelX <= GlobalX(3 downto 0);

PositionY0 <= GlobalY(8 downto 4);
posPixelY <= GlobalY(3 downto 0);

end Behavioral;
