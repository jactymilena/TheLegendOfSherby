----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2019 08:34:20 PM
-- Design Name: 
-- Module Name: testBench - Behavioral
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

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;


ENTITY tile_actor_buffer_tb IS          
END tile_actor_buffer_tb;


ARCHITECTURE behavioral OF tile_actor_buffer_tb IS 

component tile_actor_buffer is
    Port ( i_pixel_x : in STD_LOGIC_VECTOR (3 downto 0);
           i_pixel_y : in STD_LOGIC_VECTOR (3 downto 0);
           i_tile_id : in STD_LOGIC_VECTOR (7 downto 0);
           o_color_code : out STD_ULOGIC_VECTOR (3 downto 0));
end component;
  

   SIGNAL cc_sim    : STD_ULOGIC_VECTOR (3 downto 0);

   SIGNAL pixel_x_test : STD_LOGIC_VECTOR (3 downto 0);  -- Création d'un signal interne (3 bits)
   SIGNAL pixel_y_test : STD_LOGIC_VECTOR (3 downto 0);  -- Création d'un signal interne (3 bits)
   SIGNAL tile_id_test : STD_LOGIC_VECTOR (7 downto 0);  -- Création d'un signal interne (3 bits)
   

   CONSTANT PERIOD    : time := 10 ns;                  --  *** à ajouter avant le premier BEGIN

BEGIN
  UUT: tile_actor_buffer PORT MAP(
      i_pixel_x     => pixel_x_test, 
      i_pixel_y     => pixel_y_test,
      i_tile_id     => tile_id_test,
      o_color_code  => cc_sim
   );
 
-- *** Test Bench - User Defined Section ***
-- l'intérêt de cette structure de test bench est que l'on recopie la table de vérité.

   tb : PROCESS
   BEGIN
         wait for PERIOD;
         pixel_x_test <= "0000";   
         pixel_y_test <= "0000";
         tile_id_test <= "00000001";
         wait for PERIOD;
         pixel_x_test <= "0001";   
         pixel_y_test <= "0001";
         tile_id_test <= "00000001";
         wait for PERIOD;
         pixel_x_test <= "0000";   
         pixel_y_test <= "0001";
         tile_id_test <= "00000001";         
         wait for PERIOD;
         pixel_x_test <= "0010";   
         pixel_y_test <= "1000";
         tile_id_test <= "00000001";

                  
         WAIT; -- will wait forever
   END PROCESS;
END;