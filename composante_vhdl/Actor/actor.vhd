----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/10/2022 01:39:34 PM
-- Design Name: 
-- Module Name: actor - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity actor is
    Port ( i_gb_x           : in STD_LOGIC_VECTOR (8 downto 0);
           i_gb_y           : in STD_LOGIC_VECTOR (8 downto 0);
           i_set_x          : in STD_LOGIC_VECTOR (8 downto 0);
           i_set_y          : in STD_LOGIC_VECTOR (8 downto 0);
           i_tid            : in STD_LOGIC_VECTOR (7 downto 0);
           i_actor_id       : in STD_LOGIC_VECTOR (3 downto 0);
           i_curr_actor_id  : in STD_LOGIC_VECTOR (3 downto 0);
           i_we_pos         : in STD_LOGIC;
           i_we_tile        : in STD_LOGIC;
           o_tid            : out STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
           o_pix_x          : out STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
           o_pix_y          : out STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
           o_hit            : out STD_LOGIC := '0'); -- quand a 1, l'acteur se trouve a la pos globale
end actor;

architecture Behavioral of actor is   

    signal s_pos_x  : STD_LOGIC_VECTOR (8 downto 0) := (others => '0');
    signal s_pos_y  : STD_LOGIC_VECTOR (8 downto 0) := (others => '0');
    signal test2  : STD_LOGIC_VECTOR (8 downto 0) := (others => '0');
    signal test     : INTEGER;
    signal s_tid    : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

begin
    process(i_curr_actor_id, i_gb_x, i_gb_y)
    begin
        if(i_curr_actor_id = i_actor_id) then
            if(i_we_pos = '1') then
                s_pos_x <= i_set_x;
                s_pos_y <= i_set_y;
            end if;
            
            if(i_we_tile = '1') then
                s_tid <= i_tid;
            end if;
            
            -- Comparateur
            if(((s_pos_x <= i_gb_x) and (to_integer(unsigned(s_pos_x)) + 16 > to_integer(unsigned(i_gb_x)))) and
              (((s_pos_y <= i_gb_y) and (to_integer(unsigned(s_pos_y)) + 16 > to_integer(unsigned(i_gb_y)))))) then 
                o_hit <= '1';
                test2 <= std_logic_vector((unsigned(i_gb_x) + unsigned(s_pos_x)));
                test <= to_integer(unsigned(i_gb_x)) - to_integer(unsigned(s_pos_x));
                
                o_pix_x <= std_logic_vector(unsigned(i_gb_x) - unsigned(s_pos_x));
                o_pix_y <= std_logic_vector(unsigned(i_gb_y) - unsigned(s_pos_y));
            else
                o_hit <= '0';
            end if;

        end if;
    end process;
    
    o_tid <= s_tid;
        
end Behavioral;
