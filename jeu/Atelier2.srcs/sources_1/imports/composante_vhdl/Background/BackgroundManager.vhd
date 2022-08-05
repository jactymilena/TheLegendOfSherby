----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.07.2022 15:49:10
-- Design Name: 
-- Module Name: BackgroundManager - Behavioral
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

entity BackgroundManager is
    Port ( clk      : in std_logic;
           PositionX : in STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
           PositionY : in STD_LOGIC_VECTOR (3 downto 0):= (others => '0');
           SetTuileX : in STD_LOGIC_VECTOR (8 downto 0):= (others => '0');
           SetTuileY : in STD_LOGIC_VECTOR (8 downto 0):= (others => '0');
           TuileId   : in STD_LOGIC_VECTOR (7 downto 0):= (others => '0');
	       i_backgroundTile_XY_we  : in STD_LOGIC := '0';
       --    SetMap    : in  STD_LOGIC_VECTOR(3 downto 0);
           colorCode : out STD_ULOGIC_VECTOR (3 downto 0));
end BackgroundManager;

architecture Behavioral of BackgroundManager is

component tileBgBuffer is
    Port ( 
            clk : in std_logic;
            pixel_X : in STD_LOGIC_VECTOR (3 downto 0);
            pixel_Y : in STD_LOGIC_VECTOR (3 downto 0);
            tileId : in STD_LOGIC_VECTOR (7 downto 0);
            colorCode : out STD_ULOGIC_VECTOR (3 downto 0));
           
end component;

signal sel_tileX, sel_tileY : STD_LOGIC_VECTOR (4 downto 0);              
signal sel_pixelX, sel_pixelY : STD_LOGIC_VECTOR (3 downto 0);  
signal s_tileId: STD_LOGIC_VECTOR (7 downto 0);
--signal s_background : RegistreTileId;
--signal s_map_Enable, s_bg_WE : std_logic := '1';

begin


inst_buffer: tileBgBuffer 
Port map(
 clk         => clk,
 pixel_X     => PositionX,
 pixel_Y     => PositionY,
 tileId      => TuileId,
colorCode    => colorCode
);

end Behavioral;
