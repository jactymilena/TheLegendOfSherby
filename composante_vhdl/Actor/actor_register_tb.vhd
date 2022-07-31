----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/30/2022 05:00:32 PM
-- Design Name: 
-- Module Name: actor_register_tb - Behavioral
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

entity actor_register_tb is
--  Port ( );
end actor_register_tb;

architecture Behavioral of actor_register_tb is

    component actor_register is
        Port (  i_set_actor_x        : in STD_LOGIC_VECTOR (8 downto 0);   
                i_set_actor_y        : in STD_LOGIC_VECTOR (8 downto 0);   
                i_actor_id           : in STD_LOGIC_VECTOR (3 downto 0);   
                i_global_x           : in STD_LOGIC_VECTOR (8 downto 0);   
                i_global_y           : in STD_LOGIC_VECTOR (8 downto 0);   
                i_we_pos             : in STD_LOGIC;                       
                i_we_actif           : in STD_LOGIC;                       
                i_we_tile            : in STD_LOGIC;                       
                i_tid                : in STD_LOGIC_VECTOR (7 downto 0);   
                i_clk                : in STD_LOGIC;                       
                o_actor_actif        : out STD_LOGIC;                       
                o_tid                : out STD_LOGIC_VECTOR (7 downto 0);  
                o_pixel_x            : out STD_LOGIC_VECTOR (3 downto 0);  
                o_pixel_y            : out STD_LOGIC_VECTOR (3 downto 0)); 
    end component;

-- signaux en sortie
signal sim_actor_actif          : STD_LOGIC;
signal sim_tid                  : STD_LOGIC_VECTOR (7 downto 0); 
signal sim_pixel_x              : STD_LOGIC_VECTOR (3 downto 0); 
signal sim_pixel_y              : STD_LOGIC_VECTOR (3 downto 0);

-- signaux en entree
signal test_set_actor_x         : STD_LOGIC_VECTOR (8 downto 0);
signal test_set_actor_y         : STD_LOGIC_VECTOR (8 downto 0);
signal test_actor_id            : STD_LOGIC_VECTOR (3 downto 0);
signal test_global_x            : STD_LOGIC_VECTOR (8 downto 0);
signal test_global_y            : STD_LOGIC_VECTOR (8 downto 0);
signal test_actorSetPos_we      : STD_LOGIC;                    
signal test_actorSetActive_we   : STD_LOGIC;                    
signal test_actorSetTile_we     : STD_LOGIC;                    
signal test_actorBuffer_we      : STD_LOGIC; 
signal test_tid                 : STD_LOGIC_VECTOR (7 downto 0);                    
signal test_clk                 : STD_LOGIC := '0';                    

CONSTANT PERIOD    : time := 10 ns;

begin


    inst_actor_reg : actor_register 
        Port map ( 
               i_set_actor_x      => test_set_actor_x       ,
               i_set_actor_y      => test_set_actor_y       ,
               i_actor_id         => test_actor_id          ,
               i_global_x         => test_global_x          ,
               i_global_y         => test_global_y          ,
               i_we_pos           => test_actorSetPos_we    ,
               i_we_actif         => test_actorSetActive_we ,
               i_we_tile          => test_actorSetTile_we   ,
               i_tid              => test_tid               ,   
               i_clk              => test_clk               ,   
               o_actor_actif      => sim_actor_actif        ,   
               o_tid              => sim_tid                ,   
               o_pixel_x          => sim_pixel_x            ,   
               o_pixel_y          => sim_pixel_y                
        );
        
        

     tb : PROCESS
       BEGIN
         
         wait for PERIOD; -- 0
         test_set_actor_x         <= "000000001";
         test_set_actor_y         <= "000000000";
         test_actor_id            <= "0000";
         test_global_x            <= "000000000";
         test_global_y            <= "000000000";
         test_actorSetPos_we      <= '1';
         test_actorSetActive_we   <= '1';
         test_actorSetTile_we     <= '1';
         test_tid                 <= "00000001";
         
         wait for PERIOD; -- 1
         test_set_actor_x         <= "100100000";
         test_set_actor_y         <= "100000100";
         test_actor_id            <= "0001";
         test_actorSetPos_we      <= '1';
         test_actorSetActive_we   <= '0';
         test_actorSetTile_we     <= '1';
         test_tid                 <= "00000010";
         
         wait for PERIOD; -- 2
         test_set_actor_x         <= "000101000";
         test_set_actor_y         <= "001000100";
         test_actor_id            <= "0010";
         test_actorSetPos_we      <= '1';
         test_actorSetActive_we   <= '0';
         test_actorSetTile_we     <= '1';
         test_tid                 <= "00000110";
         
         wait for PERIOD; -- 3
         test_set_actor_x         <= "100101000";
         test_set_actor_y         <= "001000100";
         test_actor_id            <= "0011";
         test_actorSetPos_we      <= '1';
         test_actorSetActive_we   <= '0';
         test_actorSetTile_we     <= '1';
         test_tid                 <= "00000111";
         
         wait for PERIOD; -- 4
         test_set_actor_x         <= "000000001";
         test_set_actor_y         <= "001000100";
         test_actor_id            <= "0100";
         test_actorSetPos_we      <= '1';
         test_actorSetActive_we   <= '0';
         test_actorSetTile_we     <= '1';
         test_tid                 <= "00000111";
         
         wait for PERIOD; -- 5
         test_set_actor_x         <= "000000001";
         test_set_actor_y         <= "000000000";
         test_actor_id            <= "0101";
         test_global_x            <= "000000000";
         test_global_y            <= "000000000";
         test_actorSetPos_we      <= '1';
         test_actorSetActive_we   <= '1';
         test_actorSetTile_we     <= '1';
         test_tid                 <= "00000001";
         
         wait for PERIOD; -- 6
         test_set_actor_x         <= "000100000";
         test_set_actor_y         <= "000000100";
         test_actor_id            <= "0110";
         test_global_x            <= "000000000";
         test_actorSetPos_we      <= '1';
         test_actorSetActive_we   <= '0';
         test_actorSetTile_we     <= '1';
         test_tid                 <= "00000010";
         
         wait for PERIOD; -- 7
         test_set_actor_x         <= "000101000";
         test_set_actor_y         <= "001000100";
         test_actor_id            <= "0111";
         test_actorSetPos_we      <= '1';
         test_actorSetActive_we   <= '0';
         test_actorSetTile_we     <= '1';
         test_tid                 <= "00000110";
         
         wait for PERIOD; -- 8
         test_set_actor_x         <= "100101000";
         test_set_actor_y         <= "001000100";
         test_actor_id            <= "1000";
         test_actorSetPos_we      <= '1';
         test_actorSetActive_we   <= '0';
         test_actorSetTile_we     <= '1';
         test_tid                 <= "10000101";
         
         wait for PERIOD; -- 9
         test_set_actor_x         <= "000000001";
         test_set_actor_y         <= "001000100";
         test_actor_id            <= "1001";
         test_actorSetPos_we      <= '1';
         test_actorSetActive_we   <= '0';
         test_actorSetTile_we     <= '1';
         test_tid                 <= "00010110";
         
         wait for PERIOD; -- 10
         test_set_actor_x         <= "100101000";
         test_set_actor_y         <= "001000100";
         test_actor_id            <= "1010";
         test_actorSetPos_we      <= '1';
         test_actorSetActive_we   <= '0';
         test_actorSetTile_we     <= '1';
         test_tid                 <= "00010111";
         
         wait for PERIOD; -- 9
         test_set_actor_x         <= "000000001";
         test_set_actor_y         <= "000000010";
         test_actor_id            <= "1011";
         test_actorSetPos_we      <= '1';
         test_actorSetActive_we   <= '0';
         test_actorSetTile_we     <= '1';
         test_tid                 <= "10000111";



    
         wait for PERIOD;  
         test_set_actor_x         <= "000000000";
         test_set_actor_y         <= "000000000";
         test_actor_id            <= "0000";
         test_global_x            <= "000000001";
         test_global_y            <= "000000000";
         test_actorSetPos_we      <= '0';
         test_actorSetTile_we     <= '0';
         test_actorBuffer_we      <= '0';
         test_tid                 <= "00000000";
          
         WAIT; -- will wait forever
       END PROCESS;

end Behavioral;
