----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.07.2022 11:31:47
-- Design Name: 
-- Module Name: Actor_TB - Behavioral
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

entity Actor_TB is
--  Port ( );
end Actor_TB;

architecture Behavioral of Actor_TB is

    component actor is
          Port ( i_gb_x           : in STD_LOGIC_VECTOR (8 downto 0);
           i_gb_y           : in STD_LOGIC_VECTOR (8 downto 0);
           i_set_x          : in STD_LOGIC_VECTOR (8 downto 0);
           i_set_y          : in STD_LOGIC_VECTOR (8 downto 0);
           i_tid            : in STD_LOGIC_VECTOR (7 downto 0);
           i_actor_id       : in STD_LOGIC_VECTOR (3 downto 0);
           i_curr_actor_id  : in STD_LOGIC_VECTOR (3 downto 0);
           i_we_pos         : in STD_LOGIC;
           i_we_tile        : in STD_LOGIC;
            i_we_actif       : in STD_LOGIC;
           o_tid            : out STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
           o_pix_x          : out STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
           o_pix_y          : out STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
             o_actif          : out STD_LOGIC;
           o_hit            : out STD_LOGIC := '0');  -- quand a 1, l'acteur se trouve a la pos globale
    end component;
    
    -- signaux de sortie
    signal sim_tid          : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal sim_pix_x        : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal sim_pix_y        : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal sim_hit          : STD_LOGIC := '0'; 
    
    -- signaux d'entree
    signal test_gb_x              : INTEGER;
    signal test_gb_y              : INTEGER;
    signal test_gb_x_b            : STD_LOGIC_VECTOR (8 downto 0);
    signal test_gb_y_b            : STD_LOGIC_VECTOR (8 downto 0);
    signal test_set_x             : STD_LOGIC_VECTOR (8 downto 0);
    signal test_set_y             : STD_LOGIC_VECTOR (8 downto 0);
    signal test_tid               : STD_LOGIC_VECTOR (7 downto 0);
    signal test_actor_id          : STD_LOGIC_VECTOR (3 downto 0);
    signal test_curr_actor_id     : STD_LOGIC_VECTOR (3 downto 0);
    signal test_we_pos            : STD_LOGIC;
    signal test_we_tile           : STD_LOGIC;
    signal sim_actif : std_logic;
    
    CONSTANT PERIOD    : time := 10 ns;
    
begin

    inst_actor : actor 
    Port map (
           i_gb_x           => test_gb_x_b,
           i_gb_y           => test_gb_y_b, 
           i_set_x          => test_set_x, 
           i_set_y          => test_set_y,        
           i_tid            => test_tid,          
           i_actor_id       => x"0",     
           i_curr_actor_id  => x"0",
           i_we_pos         => '1',       
           i_we_tile        => '1',   
           i_we_actif       => '1',   
           o_tid            => sim_tid,  
           o_pix_x          => sim_pix_x,
           o_pix_y          => sim_pix_y,
           o_actif          => sim_actif,
           o_hit            => sim_hit  
    );
    
    
    tb : PROCESS
   BEGIN
     
     wait for PERIOD;  
     test_set_x         <= "000000000";
     test_set_y         <= "000000000";
     test_tid           <= "00000000";
     wait for PERIOD;  wait for PERIOD;  wait for PERIOD;  wait for PERIOD;  
--     wait for PERIOD;  
--     test_set_x         <= "000000000";
--     test_set_y         <= "000000001";
--     test_we_pos        <= '0';
--     test_we_tile       <= '0';
--     test_tid           <= "00000000";
--     test_actor_id      <= "0000";
      test_set_x         <= "000000010";
     test_set_y         <= "000001000";
      WAIT; -- will wait forever
   END PROCESS;
   
    
    test_gb_x_b <= std_logic_vector(TO_UNSIGNED(test_gb_x, test_gb_x_b'length ));
    test_gb_y_b <= std_logic_vector(TO_UNSIGNED(test_gb_y, test_gb_y_b'length ));
    
 
   
   position: process
    begin
    loop
        wait for PERIOD;
        test_gb_x <= (test_gb_x+1) mod 256;
        if(test_gb_x = 255) then 
            test_gb_y <= (test_gb_y+1) mod 224;
        end if;
       
    end loop;
    
    end process;

end Behavioral;
