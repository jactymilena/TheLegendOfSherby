----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/31/2022 06:23:04 PM
-- Design Name: 
-- Module Name: actor_manager_tb - Behavioral
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

entity actor_manager_tb is
--  Port ( );
end actor_manager_tb;

architecture Behavioral of actor_manager_tb is
    component actor_manager is
        Port ( i_clk                : in STD_LOGIC;
               i_global_x           : in STD_LOGIC_VECTOR (8 downto 0);
               i_global_y           : in STD_LOGIC_VECTOR (8 downto 0);
               i_set_actor_x        : in STD_LOGIC_VECTOR (8 downto 0);
               i_set_actor_y        : in STD_LOGIC_VECTOR (8 downto 0);
               i_actor_id           : in STD_LOGIC_VECTOR (3 downto 0);
               i_tile_id            : in STD_LOGIC_VECTOR (7 downto 0);
               i_actorSetPos_we     : in STD_LOGIC;
               i_actorSetActive_we  : in STD_LOGIC;
               i_actorSetTile_we    : in STD_LOGIC;
               i_actorBuffer_we     : in STD_LOGIC;
               o_actor_actif        : out STD_LOGIC;
               o_color_code         : out STD_ULOGIC_VECTOR (3 downto 0));
    end component;
    
    signal test_gb_x              : INTEGER := 0; 
    signal test_gb_y              : INTEGER := 0; 
    signal test_gb_x_b            : STD_LOGIC_VECTOR(8 downto 0) := (others => '0'); 
    signal test_gb_y_b            : STD_LOGIC_VECTOR(8 downto 0) := (others => '0'); 
    signal test_set_actor_x       : STD_LOGIC_VECTOR(8 downto 0) := (others => '0');
    signal test_set_actor_y       : STD_LOGIC_VECTOR(8 downto 0) := (others => '0');
    signal test_actor_id          : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal test_tile_id           : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal test_actorSetPos_we    : STD_LOGIC;
    signal test_actorSetActive_we : STD_LOGIC;
    signal test_actorSetTile_we   : STD_LOGIC;
    signal test_actorBuffer_we    : STD_LOGIC;
    signal sim_actor_actif        : STD_LOGIC;
    signal sim_color_code         : STD_ULOGIC_VECTOR(3 downto 0);
   
   CONSTANT PERIOD    : time := 10 ns;
begin
    
    inst_manager : actor_manager
        Port map (
           i_clk                => '1',
           i_global_x           => test_gb_x_b,
           i_global_y           => test_gb_Y_b,
           i_set_actor_x        => test_set_actor_x,
           i_set_actor_y        => test_set_actor_x,
           i_actor_id           => test_actor_id,
           i_tile_id            => test_tile_id,
           i_actorSetPos_we     => test_actorSetPos_we,
           i_actorSetActive_we  => test_actorSetActive_we,
           i_actorSetTile_we    => test_actorSetTile_we,  
           i_actorBuffer_we     => test_actorBuffer_we,   
           o_actor_actif        => sim_actor_actif,      
           o_color_code         => sim_color_code       
        );
        
       tb : PROCESS
       BEGIN
         
         wait for PERIOD;
         test_set_actor_x        <= "000000000";
         test_set_actor_y        <= "000000000";
         test_actor_id           <= "0000";
         test_tile_id            <= "00000001";
         test_actorSetPos_we     <= '1';
         test_actorSetActive_we  <= '1';
         test_actorSetTile_we    <= '1';
         test_actorBuffer_we     <= '1';
        
        
         
         WAIT; -- will wait forever
       END PROCESS;
       
       test_gb_x_b <= std_logic_vector(TO_UNSIGNED(test_gb_x, test_gb_x_b'length));
       test_gb_y_b <= std_logic_vector(TO_UNSIGNED(test_gb_y, test_gb_y_b'length));

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
