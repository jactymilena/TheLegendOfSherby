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

    signal s_tid    : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    
    signal s_pos_x  : INTEGER := 0;
    signal test     : INTEGER := 0;
    signal test2     : INTEGER := 0;
    signal s_pos_y  : INTEGER := 0;
    signal s_gb_x   : INTEGER := 0;
    signal s_gb_y   : INTEGER := 0;
    signal test3          : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');

begin
    s_gb_x <= TO_INTEGER(UNSIGNED(i_gb_x));
    s_gb_y <= TO_INTEGER(UNSIGNED(i_gb_y));
    o_tid <= s_tid;
    
    -- write-enable set position
    process(i_we_pos)
    begin
        if(i_we_pos = '1' and i_curr_actor_id = i_actor_id) then
            s_pos_x <= TO_INTEGER(UNSIGNED(i_set_x));
            s_pos_y <= TO_INTEGER(UNSIGNED(i_set_y));
        end if;
    end process;
    
    -- write-enable set tile id
    process(i_we_tile)
    begin
        if(i_we_tile = '1' and i_curr_actor_id = i_actor_id) then
            s_tid <= i_tid;
        end if;
    end process;
    
    -- Comparateur
    process(i_curr_actor_id, i_gb_x, i_gb_y)
    begin
        if(i_curr_actor_id = i_actor_id) then
            
            if(((s_pos_x <= s_gb_x) and (s_pos_x + 16 > s_gb_x)) and
              ((s_pos_y <= s_gb_y) and (s_pos_y + 16 > s_gb_y))) then 
                o_hit <= '1';                
                test3 <= std_logic_vector(TO_UNSIGNED(2-0,test3'length));       -- 2 - 0 = 2
                test <= 2 - 0;                                                  -- 2 - 0 = 2
                test2 <= (s_gb_x) - (s_pos_x);                                  -- 2 - 0 = 1
                o_pix_x <= std_logic_vector(TO_UNSIGNED((s_gb_x) - (s_pos_x), o_pix_x'length));
                o_pix_y <= std_logic_vector(TO_UNSIGNED((s_gb_y) - (s_pos_y), o_pix_y'length));
            else
                o_hit <= '0';
            end if;
        end if;
    end process;
   
end Behavioral;
