----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/07/2022 06:55:01 PM
-- Design Name: 
-- Module Name: MuxCC - Behavioral
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
use work.tuile_package.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MuxCC is
    Port (
           i_global_x             : in STD_LOGIC_VECTOR (8 downto 0);
           i_global_y             : in STD_LOGIC_VECTOR (8 downto 0);
           i_set_actor_x          : in STD_LOGIC_VECTOR (8 downto 0);
           i_set_actor_y          : in STD_LOGIC_VECTOR (8 downto 0);
           i_actor_id             : in STD_LOGIC_VECTOR (3 downto 0);
           i_a_tid                : in STD_LOGIC_VECTOR  (7 downto 0);
           i_actorSetPos_we       : in STD_LOGIC;
           i_actorSetActive_we    : in STD_LOGIC;
           i_actorSetTile_we      : in STD_LOGIC;
           i_actorBuffer_we       : in STD_LOGIC;
           SetTuileX              : in STD_LOGIC_VECTOR (8 downto 0);
           SetTuileY              : in STD_LOGIC_VECTOR (8 downto 0);
           TuileId                : in STD_LOGIC_VECTOR (7 downto 0);
           i_backgroundTile_XY_we : in STD_LOGIC := '0';
           o_color_code           : out STD_ULOGIC_VECTOR (3 downto 0)
    );
end MuxCC;

architecture Behavioral of MuxCC is

    component BackgroundManager is
        Port ( clk                      : in std_ulogic;
               PositionX                : in STD_LOGIC_VECTOR (8 downto 0);
               PositionY                : in STD_LOGIC_VECTOR (8 downto 0);
               SetTuileX                : in STD_LOGIC_VECTOR (8 downto 0);
               SetTuileY                : in STD_LOGIC_VECTOR (8 downto 0);
               TuileId                  : in STD_LOGIC_VECTOR (7 downto 0);
               i_backgroundTile_XY_we   : in STD_LOGIC := '0';
               colorCode                : out STD_ULOGIC_VECTOR (3 downto 0));
    end component;

    component actor_manager is
        Port ( i_clk                : in STD_LOGIC;
               i_global_x           : in STD_LOGIC_VECTOR (8 downto 0);
               i_global_y           : in STD_LOGIC_VECTOR (8 downto 0);
               i_set_actor_x        : in STD_LOGIC_VECTOR (8 downto 0);
               i_set_actor_y        : in STD_LOGIC_VECTOR (8 downto 0);
               i_actor_id           : in STD_LOGIC_VECTOR (3 downto 0);
               i_tile_id            : in STD_LOGIC_VECTOR  (7 downto 0);
               i_actorSetPos_we     : in STD_LOGIC;
               i_actorSetActive_we  : in STD_LOGIC;
               i_actorSetTile_we    : in STD_LOGIC;
               i_actorBuffer_we     : in STD_LOGIC;
               o_actor_actif        : out STD_LOGIC;
               o_color_code         : out STD_ULOGIC_VECTOR (3 downto 0));
    end component;
    
    signal s_cc_actor   : STD_ULOGIC_VECTOR (3 downto 0);
    signal s_cc_bg      : STD_ULOGIC_VECTOR (3 downto 0);
    signal s_actor_actif        : STD_LOGIC;
begin


    inst_bg : BackgroundManager 
        Port map ( 
               clk                      => '0',
               PositionX                => i_global_x,
               PositionY                => i_global_y,
               SetTuileX                => SetTuileX,
               SetTuileY                => SetTuileY,
               TuileId                  => TuileId,
               i_backgroundTile_XY_we   => i_backgroundTile_XY_we,
               colorCode                => s_cc_bg
        );

    inst_actor : actor_manager 
        Port map ( 
               i_clk               => '0',
               i_global_x          => i_global_x,
               i_global_y          => i_global_y,
               i_set_actor_x       => i_set_actor_x     ,
               i_set_actor_y       => i_set_actor_y     ,
               i_actor_id          => i_actor_id        ,
               i_tile_id           => i_a_tid           ,
               i_actorSetPos_we    => i_actorSetPos_we  ,
               i_actorSetActive_we => i_actorSetActive_we,
               i_actorSetTile_we   => i_actorSetTile_we ,
               i_actorBuffer_we    => i_actorBuffer_we  ,
               o_actor_actif       => s_actor_actif      ,
               o_color_code        => s_cc_actor
        );
       
       -- MUX 
       o_color_code <= s_cc_bg when (s_actor_actif = '0') or (s_cc_actor = TRANS_CC) else
                       s_cc_actor;
       
  
end Behavioral;
