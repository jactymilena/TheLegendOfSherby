----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/28/2022 12:52:44 PM
-- Design Name: 
-- Module Name: ScrollY - Behavioral
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

entity ScrollY is
    Port ( i_SetActorY : in STD_LOGIC_VECTOR (8 downto 0);
           ActorID : in STD_LOGIC_VECTOR (3 downto 0);
           i_clk: in STD_LOGIC;
           i_en: in STD_LOGIC;
           o_OffsetY : out STD_LOGIC_VECTOR (8 downto 0));
end ScrollY;

architecture Behavioral of ScrollY is

begin
offset : process (i_clk, i_en)
   begin
      if (rising_edge(i_clk) AND i_en = '1') then
          if (i_SetActorY = "000000000" AND ActorId = "0000") then
            o_OffsetY <= "011011111";
          else
            o_OffSetY<= "000000000";
          end if;
      end if;
   end process;

end Behavioral;
