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
    Port ( i_instruction : in STD_LOGIC_VECTOR (31 downto 0));
end PPU;

architecture Behavioral of PPU is
component PPUCore
port ( i_instruction : in STD_LOGIC_VECTOR (31 downto 0);
           o_control : out STD_LOGIC_VECTOR (31 downto 27);
           o_actor_x : out STD_LOGIC_VECTOR (17 downto 9);
           o_actor_y : out STD_LOGIC_VECTOR (8 downto 0);
           o_actor_actif : out std_logic;
           o_actor_id: out STD_LOGIC_VECTOR (26 downto 23);
           o_tile_id: out STD_LOGIC_VECTOR (25 downto 18)
           );
end component;
component Control
port ( i_opcode : in STD_LOGIC_VECTOR (31 downto 27);
           o_actorSetPos_XY_we : out STD_LOGIC;
           o_actorSetPos_X_we : out STD_LOGIC;
           o_actorSetPos_Y_we : out STD_LOGIC;
           o_actorSetActive_we : out STD_LOGIC;
           o_actorSetTile_we : out STD_LOGIC;
           o_backgroundTile_XY_we : out STD_LOGIC;
           -- o_backgroundTile_X_we : out STD_LOGIC;
           -- o_backgroundTile_Y_we : out STD_LOGIC;
           o_actorBuffer_we : out STD_LOGIC);
end component;
signal s_control: std_logic_vector (4 downto 0);
begin
    core : PPUCore
    port map (
        i_instruction   => i_instruction,
        o_control       => s_control
    );
    
    controller : Control
    port map (
        i_opcode        => s_control
    );
end Behavioral;
