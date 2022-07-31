----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/28/2022 12:52:44 PM
-- Design Name: 
-- Module Name: ScrollX - Behavioral
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

entity ScrollX is
    Port ( i_SetActorX : in STD_LOGIC_VECTOR (8 downto 0);
           i_clk: in STD_LOGIC;
           i_en: in STD_LOGIC;
           ActorId : in STD_LOGIC_VECTOR (3 downto 0);
           o_OffsetX : out STD_LOGIC_VECTOR (8 downto 0));
end ScrollX;

architecture Behavioral of ScrollX is

begin
offset : process (i_clk, i_en)
   begin
      if (rising_edge(i_clk) AND i_en = '1') then
          if (i_SetActorX = "000000000" AND ActorId = "0000") then
            o_OffsetX <= "011111111";
          else
            o_OffSetX<= "000000000";
          end if;
      end if;
   end process;

end Behavioral;
