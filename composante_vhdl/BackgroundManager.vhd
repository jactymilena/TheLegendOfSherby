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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BackgroundManager is
    Port ( clk      : in std_ulogic;
           PositionX : in STD_LOGIC_VECTOR (8 downto 0);
           PositionY : in STD_LOGIC_VECTOR (8 downto 0);
           SetTuileX : in STD_LOGIC_VECTOR (8 downto 0);
           SetTuileY : in STD_LOGIC_VECTOR (8 downto 0);
           TuileId : in STD_LOGIC_VECTOR (7 downto 0);
           colorCode : out STD_LOGIC_VECTOR (3 downto 0));
end BackgroundManager;

architecture Behavioral of BackgroundManager is

component comparateurBackground is
    Port ( GlobalX : in STD_LOGIC_VECTOR (8 downto 0);
           GlobalY : in STD_LOGIC_VECTOR (8 downto 0);
           PositionX0 : out STD_LOGIC_VECTOR (4 downto 0);
           PositionY0 : out STD_LOGIC_VECTOR (4 downto 0);
           posPixelX  : out STD_LOGIC_VECTOR (3 downto 0);
           posPixelY  : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component tileBgBuffer is
    Port ( 
            pixel_X : in STD_LOGIC_VECTOR (3 downto 0);
            pixel_Y : in STD_LOGIC_VECTOR (3 downto 0);
            tileId : in STD_LOGIC_VECTOR (7 downto 0);
           colorCode : out STD_LOGIC_VECTOR (3 downto 0));
           
end component;
component registreTuile is
    Port ( 
            clk : in std_ulogic;
            setTuileX : in STD_LOGIC_VECTOR (8 downto 0);
            setTuileY : in STD_LOGIC_VECTOR (8 downto 0);
            SetTileId : in STD_LOGIC_VECTOR (7 downto 0);
            
            colX      : in STD_LOGIC_VECTOR (4 downto 0);
            rangerY   : in STD_LOGIC_VECTOR (4 downto 0);
            tileId    : out STD_LOGIC_VECTOR (7 downto 0));
--            tuileX    : out std_logic_vector (8 downto 0);
--            tuileY    : out std_logic_vector (8 downto 0));
           
end component;

signal sel_tileX, sel_tileY : STD_LOGIC_VECTOR (8 downto 0);              
signal sel_pixelX, sel_pixelY : STD_LOGIC_VECTOR (3 downto 0);  
signal s_tileId: STD_LOGIC_VECTOR (7 downto 0);
begin


inst_buffer: tileBgBuffer 
Port map(
 pixel_X     => sel_pixelX,
 pixel_Y     => sel_pixelY,
 tileId      => s_tileId,
colorCode    => colorCode
);

inst_comp: comparateurBackground 
Port map(
GlobalX      => PositionX,
GlobalY      => PositionY,
PositionX0   => sel_tileX,
PositionY0   => sel_tileY,
posPixelX    => sel_pixelX,
posPixelY    => sel_pixelY
);

inst_regTuile: registreTuile
Port map(
clk        => clk,
setTuileX  => SetTuileX,
setTuileY  => SetTuileY,
SetTileId  => TuileId,
colX       => sel_tileX,
rangerY    => sel_tileY,
tileId     => s_tileId
);
end Behavioral;
