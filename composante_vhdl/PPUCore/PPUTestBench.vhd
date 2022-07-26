----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/26/2022 09:58:51 AM
-- Design Name: 
-- Module Name: PPUTestBench - Behavioral
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

entity PPUTestBench is
--  Port ( );
end PPUTestBench;

architecture Behavioral of PPUTestBench is
    component PPU is
        Port ( i_instruction : in STD_LOGIC_VECTOR (31 downto 0));
    end component;
    CONSTANT c_delai : time := 20ns;
    signal instruction : std_logic_vector (31 downto 0);
begin
    
   m_PPU : PPU
   Port map(
        i_instruction => instruction
   );
   
   process
   begin
        wait for c_delai;
        instruction <= "00001000000000000000000000000000";
        wait for c_delai;   
        instruction <= "00010000000000000000000000000000";
        wait for c_delai;   
        instruction <= "00011000000000000000000000000000";
        wait for c_delai;   
        instruction <= "00100000000000000000000000000000";
        wait for c_delai;   
        instruction <= "00101000000000000000000000000000";
        wait for c_delai;   
        instruction <= "00110000000000000000000000000000";
        wait for c_delai;   
        instruction <= "00111000000000000000000000000000";
        wait for c_delai;   
        instruction <= "01000000000000000000000000000000";
        wait for c_delai;   
        instruction <= "01001000000000000000000000000000";
        wait for c_delai;   
        instruction <= "01010000000000000000000000000000";
        wait for c_delai;   
        instruction <= "01011000000000000000000000000000";
        wait for c_delai;       
        instruction <= "01100000000000000000000000000000";
        wait for c_delai;       
        instruction <= "01101000000000000000000000000000";
        wait for c_delai;       
        instruction <= "01110000000000000000000000000000";
        wait for c_delai;       
        instruction <= "01111000000000000000000000000000";
        wait for c_delai;       
        instruction <= "10000000000000000000000000000000";
        wait for c_delai;       
        instruction <= "10001000000000000000000000000000";
        wait for c_delai;       
        instruction <= "10010000000000000000000000000000";
        wait for c_delai;       
        instruction <= "10011000000000000000000000000000";
        wait for c_delai;            
        instruction <= "10100000000000000000000000000000";
        wait for c_delai;            
        instruction <= "10101000000000000000000000000000";
        wait for c_delai;            
        instruction <= "10110000000000000000000000000000";
        wait for c_delai;            
        instruction <= "10111000000000000000000000000000";
        wait for c_delai;            
        instruction <= "11000000000000000000000000000000";
        wait for c_delai;            
        instruction <= "11001000000000000000000000000000";
        wait for c_delai;            
        instruction <= "11010000000000000000000000000000";
        wait for c_delai;            
        instruction <= "11011000000000000000000000000000";
        wait for c_delai;            
        instruction <= "11100000000000000000000000000000";
        wait for c_delai;            
        instruction <= "11101000000000000000000000000000";
        wait for c_delai;            
        instruction <= "11110000000000000000000000000000";
        wait for c_delai;            
        instruction <= "11111000000000000000000000000000";
        wait for c_delai;            
   end process;

end Behavioral;
