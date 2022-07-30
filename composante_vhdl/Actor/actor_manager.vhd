----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/10/2022 01:53:35 PM
-- Design Name: 
-- Module Name: actor_manager - Behavioral
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

entity actor_manager is
    Port ( i_clk                : in STD_LOGIC;
           i_global_x           : in STD_LOGIC_VECTOR (8 downto 0);
           i_global_y           : in STD_LOGIC_VECTOR (8 downto 0);
           i_set_actor_x        : in STD_LOGIC_VECTOR (8 downto 0);
           i_set_actor_y        : in STD_LOGIC_VECTOR (8 downto 0);
           i_actor_id           : in STD_LOGIC_VECTOR (3 downto 0);
           i_tile_id            : in STD_LOGIC_VECTOR  (7 downto 0);
           o_actor_actif        : in STD_LOGIC;
           i_actorSetPos_we     : in STD_LOGIC;
           i_actorSetActive_we  : in STD_LOGIC;
           i_actorSetTile_we    : in STD_LOGIC;
           i_actorBuffer_we     : in STD_LOGIC;
           o_color_code         : out STD_ULOGIC_VECTOR (7 downto 0));
end actor_manager;

architecture Behavioral of actor_manager is
    component tile_actor_buffer is
        Port ( i_pixel_x            : in STD_LOGIC_VECTOR  (3 downto 0);
               i_pixel_y            : in STD_LOGIC_VECTOR  (3 downto 0);
               i_tile_id            : in STD_LOGIC_VECTOR  (7 downto 0);
               o_color_code         : out STD_ULOGIC_VECTOR (3 downto 0));
    end component;
    
    component actor_register is
    Port ( i_set_actor_x        : in STD_LOGIC_VECTOR (8 downto 0);
           i_set_actor_y        : in STD_LOGIC_VECTOR (8 downto 0);
           i_actor_id           : in STD_LOGIC_VECTOR (3 downto 0);
           i_global_x           : in STD_LOGIC_VECTOR (8 downto 0);
           i_global_y           : in STD_LOGIC_VECTOR (8 downto 0);
           i_actorSetPos_we     : in STD_LOGIC;
           i_actorSetActive_we  : in STD_LOGIC;
           i_actorSetTile_we    : in STD_LOGIC;
           i_actorBuffer_we     : in STD_LOGIC;
           i_tid                : in STD_LOGIC_VECTOR (7 downto 0);
           i_clk                : in STD_LOGIC;
           o_actor_actif        : in STD_LOGIC;
           o_tid                : out STD_LOGIC_VECTOR (7 downto 0);
           o_pixel_x            : out STD_LOGIC_VECTOR (3 downto 0);
           o_pixel_y            : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    signal s_actor_actif    : STD_LOGIC;
    signal s_tid            : STD_LOGIC_VECTOR (3 downto 0);
    signal s_pixel_x        : STD_LOGIC_VECTOR (3 downto 0);
    signal s_pixel_y        : STD_LOGIC_VECTOR (3 downto 0);

begin
    inst_tile_buff : tile_actor_buffer 
        Port map ( 
               i_pixel_x    => s_pixel_x,
               i_pixel_y    => s_pixel_y,
               i_tile_id    => s_tid,
               o_color_code => o_color_code
        );
        
    inst_actor_reg : actor_register 
        Port map ( 
           i_set_actor_x       => i_set_actor_x,
           i_set_actor_y       => i_set_actor_y,
           i_actor_id          => i_actor_id,
           i_global_x          => i_global_x,
           i_global_y          => i_global_y,
           i_actorSetPos_we    => i_actorSetPos_we,
           i_actorSetActive_we => i_actorSetActive_we,
           i_actorSetTile_we   => i_actorSetTile_we,
           i_actorBuffer_we    => i_actorBuffer_we,
           i_tid               => i_tile_id,
           i_clk               => i_clk,
           o_actor_actif       => s_actor_actif,
           o_tid               => s_tid,
           o_pixel_x           => s_pixel_x,
           o_pixel_y           => s_pixel_y
        );

end Behavioral;
