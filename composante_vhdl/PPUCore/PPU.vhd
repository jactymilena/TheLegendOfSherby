----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/22/2022 03:08:17 PM
-- Design Name: 
-- Module Name: PPU - Behavioral
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

entity PPU is
    Port ( i_instruction : in STD_LOGIC_VECTOR (31 downto 0) ;
           clk          : in std_logic;
           o_couleur : out STD_LOGIC_VECTOR (23 downto 0);
           o_control : out STD_LOGIC_VECTOR (3 downto 0));
end PPU;

architecture Behavioral of PPU is
component PPUCore
port ( i_instruction : in STD_LOGIC_VECTOR (31 downto 0);
           o_control : out STD_LOGIC_VECTOR (31 downto 27);
           o_actor_x : out STD_LOGIC_VECTOR (17 downto 9);
           o_actor_y : out STD_LOGIC_VECTOR (8 downto 0);
           o_actor_actif : out std_logic;
           o_actor_id: out STD_LOGIC_VECTOR (26 downto 23);
           o_ActorTile_id : out STD_LOGIC_VECTOR (25 downto 18);
           o_BgTile_id : out STD_LOGIC_VECTOR (25 downto 18)
           );
end component;
component Control
port ( i_opcode : in STD_LOGIC_VECTOR (31 downto 27);
           o_actorSetPos_XY_we    : out STD_LOGIC;
           o_actorSetPos_X_we     : out STD_LOGIC;
           o_actorSetPos_Y_we     : out STD_LOGIC;
           o_actorSetActive_we    : out STD_LOGIC;
           o_actorSetTile_we      : out STD_LOGIC;
           o_backgroundTile_XY_we : out STD_LOGIC;
           o_actorBuffer_we       : out STD_LOGIC);
end component;
component compteur_pixel is
   Port ( i_reset : in STD_LOGIC;
      --     i_enable : in STD_LOGIC;
           i_clk : in STD_LOGIC;
   --        i_scrollX  :in std_logic_vector(8 downto 0);
   --        i_scrollY  :in std_logic_vector(8 downto 0);
           o_PositionX : out STD_LOGIC_VECTOR (8 downto 0);
           o_PositionY : out STD_LOGIC_VECTOR (8 downto 0));
end component;
component BackgroundManager is
    Port ( clk      : in std_ulogic;
           PositionX : in STD_LOGIC_VECTOR (8 downto 0);
           PositionY : in STD_LOGIC_VECTOR (8 downto 0);
           SetTuileX : in STD_LOGIC_VECTOR (8 downto 0);
           SetTuileY : in STD_LOGIC_VECTOR (8 downto 0);
           TuileId   : in STD_LOGIC_VECTOR (7 downto 0);
	       i_backgroundTile_XY_we  : in STD_LOGIC := '0';
           colorCode : out STD_ULOGIC_VECTOR (3 downto 0));
end component;
component actor_manager is
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
end component;

component color_converter is
    Port ( code : in STD_LOGIC_VECTOR (3 downto 0);
           color : out STD_LOGIC_VECTOR (23 downto 0));
end component;

component frame_printer is
    Port ( PositionX : in STD_LOGIC_VECTOR (8 downto 0);
           PositionY : in STD_LOGIC_VECTOR (8 downto 0);
           i_clk: in STD_LOGIC;
           i_rst: in STD_LOGIC;
           i_en: in STD_LOGIC;
           control : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal s_control: std_logic_vector (4 downto 0);
-- background manager
signal s_pos_bg_x, s_pos_bg_y : std_logic_vector(8 downto 0);
signal s_tileId_bg: STD_LOGIC_VECTOR (7 downto 0);
signal s_bgTile_WE : std_logic;

-- compteur Pixel
signal s_global_cmp_x, s_global_cmp_y :STD_LOGIC_VECTOR (8 downto 0);

-- code Couleur
signal s_codeColor_FINAL : std_ulogic_vector(3 downto 0);
signal s_mux_In1_bg_colorCode : std_ulogic_vector(3 downto 0);
signal s_mux_In2_actor_colorCode : std_ulogic_vector(3 downto 0);
signal s_muxSelec_acteurIsActif :std_logic;

-- acteur manager
signal s_pos_actor_x, s_pos_actor_y : std_logic_vector(8 downto 0);   
signal s_tileId_actor: STD_LOGIC_VECTOR (7 downto 0);  
signal s_actorId_actor: STD_LOGIC_VECTOR (3 downto 0);    
signal s_actorPos_X_WE, s_actorPos_Y_WE, s_actorPos_XY_WE : std_logic;
signal s_actor_Active_WE, s_actor_Tile_WE : std_logic;
signal  s_actor_Buffer_WE : std_logic;

         
begin
    inst_core : PPUCore
    port map (
        i_instruction   => i_instruction,
         o_control  => s_control,
         o_actor_x  => s_pos_bg_x,
         o_actor_y  => s_pos_bg_y,
         o_actor_actif =>  s_actor_Active_WE,
         o_actor_id  => s_actorId_actor,
         o_ActorTile_id => s_tileId_actor,
         o_BgTile_id    => s_tileId_bg
    );
    inst_controller : Control
    port map (
        i_opcode        => s_control,
        o_actorSetPos_XY_we  => s_actorPos_XY_WE,
        o_actorSetPos_X_we   => s_actorPos_X_WE,
        o_actorSetPos_Y_we   => s_actorPos_Y_WE,
        o_actorSetActive_we  => s_actor_Active_WE,
        o_actorSetTile_we    => s_actor_Tile_WE,
        o_backgroundTile_XY_we => s_bgTile_WE,
        o_actorBuffer_we      => s_actor_Buffer_WE
    );
    inst_compteur_pixel: compteur_pixel
    port map(
    i_reset     => '1',
--    i_enable    =>
    i_clk       => clk,
  --  i_scrollX   =>
 --   i_scrollY   => 
    o_PositionX => s_global_cmp_x,
    o_PositionY => s_global_cmp_y
    );
    inst_background: BackgroundManager
    port map(
        clk        => clk,
        PositionX  => s_global_cmp_x,
        PositionY  => s_global_cmp_y,
        SetTuileX  => s_pos_bg_x,
        SetTuileY  => s_pos_bg_y,
        TuileId    => s_tileId_bg,
        i_backgroundTile_XY_we  => s_bgTile_WE,
        colorCode  => s_mux_In1_bg_colorCode
   );
   inst_actor_manager: actor_manager
   port map (
    i_clk                => clk,
     i_global_x          => s_global_cmp_x,
     i_global_y          => s_global_cmp_y,
     i_set_actor_x       => s_pos_actor_x,
     i_set_actor_y       => s_pos_actor_y,
     i_actor_id          => s_actorId_actor,
     i_tile_id           => s_tileId_actor,
     o_actor_actif       => s_muxSelec_acteurIsActif,
     i_actorSetPos_we    => s_actorPos_XY_WE,
     i_actorSetActive_we => s_actor_Active_WE,
     i_actorSetTile_we   => s_actor_Tile_WE,
     i_actorBuffer_we    => s_actor_Buffer_WE,
     o_color_code        => s_mux_In2_actor_colorCode
   );
   
   s_codeColor_FINAL <= s_mux_In2_actor_colorCode when s_muxSelec_acteurIsActif = '1' else
                        s_mux_In1_bg_colorCode when s_muxSelec_acteurIsActif = '1' and s_mux_In2_actor_colorCode = x"0" else
                        s_mux_In1_bg_colorCode;
    inst_color_converter : color_converter
    port map (
    code => to_stdlogicvector(s_codeColor_FINAL),
    color => o_couleur
    );
    
end Behavioral;
