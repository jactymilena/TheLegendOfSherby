----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2022 03:45:26 PM
-- Design Name: 
-- Module Name: MEF_fp - Behavioral
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

entity MEF_fp is
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
end MEF_fp;

architecture Behavioral of MEF_fp is

--set les differents etats
type etats_fp is (
    init,
    start_frame,
    start_line,
    idle,
    end_line,
    end_frame
);
--set next et current state
signal next_state, current_state: etats_fp;

begin
   -- Assignation du prochain état
    process(clk, reset)
    begin
       if (reset ='1') then
             current_state <= init;
       else
       if rising_edge(clk) then
             current_state <= next_state;
       end if;
       end if;
    end process;

-- conditions de transitions
transitions: process(enable, i_x , i_y, current_state, i_cpt224, i_cpt256 )
begin
   case current_state is
        when init => 
            if enable = '0' then
                next_state <= current_state;
            elsif enable = '1' then
                next_state <= start_frame;
            else
               next_state <= current_state;
            end if;
            
        when start_frame =>
            if enable = '0' then
                next_state <= init;
            elsif enable = '1' then
                next_state <= start_line;
            else
                next_state <= init;
            end if;
            
        when start_line =>
            if enable = '0' then
                next_state <= init;
            elsif enable = '1' then
                next_state <= idle;
            else
                next_state <= init;
            end if;
            
        when idle =>
            if enable = '0' then
                next_state <= init;
            elsif enable = '1' then
                if i_cpt256 < "011111111" then
                    next_state <= idle;
                elsif i_cpt256 = "011111111" then
                    next_state <= end_line;
                else
                    next_state <= init;
                end if;
            else
                next_state <= init;
            end if;
            
        when end_line =>
            if enable = '0' then
                next_state <= init;
            elsif enable = '1' then
                if i_cpt224 < "011011111" then
                    next_state <= start_line;
                elsif i_cpt224 = "011011111" then
                    next_state <= end_frame;
                else
                    next_state <= init;
                end if;
            else
                next_state <= init;
            end if;
            
            
        when end_frame =>
            next_state <= init;
            
        when others =>
            next_state <= init;
            
   end case;
end process;

-- relations de sorties
  sortie: process(current_state, enable )
  begin
  case current_state is
        when init =>
           o_en224 <= '0';
           o_rst224 <= '0';
           o_en256 <= '0';
           o_rst256 <= '0';
           o_control <= "0000";
           
        when start_frame =>
           o_en224 <= '1';
           o_rst224 <= '0';
           o_en256 <= '0';
           o_rst256 <= '0';
           o_control <= "0001";
                   
        when start_line =>
           o_en224 <= '0';
           o_rst224 <= '0';
           o_en256 <= '1';
           o_rst256 <= '0';
           o_control <= "0010";
           
        when idle =>
           o_en224 <= '0';
           o_rst224 <= '0';
           o_en256 <= '1';
           o_rst256 <= '0';
           o_control <= "0011";
           
        when end_line =>
           o_en224 <= '0';
           o_rst224 <= '0';
           o_en256 <= '1';
           o_rst256 <= '1';
           o_control <= "0100";
           
        when end_frame =>
           o_en224 <= '0';
           o_rst224 <= '1';
           o_en256 <= '0';
           o_rst256 <= '0';
           o_control <= "0101";
           
        when others =>
           o_en224 <= '0';
           o_rst224 <= '0';
           o_en256 <= '0';
           o_rst256 <= '0';
           o_control <= "0000";
           
  end case;
  end process;

end Behavioral;
