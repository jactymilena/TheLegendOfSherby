----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/21/2022 03:18:00 PM
-- Design Name: 
-- Module Name: MEF_cpt_pix - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;  -- pour les additions avec les offsets
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEF_cpt_pix is
    Port ( i_rst : in STD_LOGIC;
           i_en : in STD_LOGIC;
           i_clk : in STD_LOGIC;
           i_OffsetX : in STD_LOGIC_VECTOR (8 downto 0);
           i_OffsetY : in STD_LOGIC_VECTOR (8 downto 0);
           i_cpt256 : in STD_LOGIC_VECTOR (7 downto 0);
           i_cpt224 : in STD_LOGIC_VECTOR (7 downto 0);
           o_en256 : out STD_LOGIC;
           o_en224 : out STD_LOGIC;
           o_rst256 : out STD_LOGIC;
           o_rst224 : out STD_LOGIC;
           o_PositionX : out STD_LOGIC_VECTOR (8 downto 0);
           o_PositionY : out STD_LOGIC_VECTOR (8 downto 0));
end MEF_cpt_pix;

architecture Behavioral of MEF_cpt_pix is
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
    process(i_clk, i_rst)
    begin
       if (i_rst ='1') then
             current_state <= init;
       else
       if rising_edge(i_clk) then
             current_state <= next_state;
       end if;
       end if;
    end process;

-- conditions de transitions
transitions: process(i_en,current_state, i_cpt224, i_cpt256 )
begin
   case current_state is
        when init => 
            if i_en = '0' then
                next_state <= current_state;
            elsif i_en = '1' then
                next_state <= start_frame;
            else
               next_state <= current_state;
            end if;
            
        when start_frame =>
            if i_en = '0' then
                next_state <= init;
            elsif i_en = '1' then
                next_state <= start_line;
            else
                next_state <= init;
            end if;
            
        when start_line =>
            if i_en = '0' then
                next_state <= init;
            elsif i_en = '1' then
                next_state <= idle;
            else
                next_state <= init;
            end if;
            
        when idle =>
            if i_en = '0' then
                next_state <= init;
            elsif i_en = '1' then
                if (i_cpt256 < "11111111") then
                    next_state <= idle;
                elsif (i_cpt256 = "11111111") then
                    next_state <= end_line;
                else
                    next_state <= init;
                end if;
            else
                next_state <= init;
            end if;
            
        when end_line =>
            if i_en = '0' then
                next_state <= init;
            elsif i_en = '1' then
                if i_cpt224 < "11011111" then
                    next_state <= start_line;
                elsif i_cpt224 = "11011111" then
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
  sortie: process(current_state, i_en )
  begin
  case current_state is
        when init =>
           o_en224 <= '0';
           o_rst224 <= '1';
           o_en256 <= '0';
           o_rst256 <= '1';
           o_PositionX <= "000000000";
           o_PositionY <= "000000000";
        when start_frame =>
           o_en224 <= '1';
           o_rst224 <= '0';
           o_en256 <= '0';
           o_rst256 <= '0';
           o_PositionX <= i_OffsetX + i_cpt256;
           o_PositionY <= i_OffsetY + i_cpt224;
                   
        when start_line =>
           o_en224 <= '0';
           o_rst224 <= '0';
           o_en256 <= '1';
           o_rst256 <= '0';
           o_PositionX <= i_OffsetX + i_cpt256;
           o_PositionY <= i_OffsetY + i_cpt224;
           
        when idle =>
           o_en224 <= '0';
           o_rst224 <= '0';
           o_en256 <= '1';
           o_rst256 <= '0';
           o_PositionX <= i_OffsetX + i_cpt256;
           o_PositionY <= i_OffsetY + i_cpt224;
           
        when end_line =>
           o_en224 <= '0';
           o_rst224 <= '0';
           o_en256 <= '1';
           o_rst256 <= '1';
           o_PositionX <= i_OffsetX + i_cpt256;
           o_PositionY <= i_OffsetY + i_cpt224;
           
        when end_frame =>
           o_en224 <= '0';
           o_rst224 <= '1';
           o_en256 <= '0';
           o_rst256 <= '0';
           o_PositionX <= i_OffsetX + i_cpt256;
           o_PositionY <= i_OffsetY + i_cpt224;
           
        when others =>
           o_en224 <= '0';
           o_rst224 <= '0';
           o_en256 <= '0';
           o_rst256 <= '0';
           o_PositionX <= "000000000";
           o_PositionY <= "000000000";
           
  end case;
  end process;

end Behavioral;
