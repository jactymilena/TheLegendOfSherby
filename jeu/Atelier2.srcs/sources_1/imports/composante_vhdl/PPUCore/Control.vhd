----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/22/2022 02:37:25 PM
-- Design Name: 
-- Module Name: Control - Behavioral
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

entity Control is
    Port ( i_opcode : in STD_LOGIC_VECTOR (31 downto 27);
           o_actorSetPos_XY_we : out STD_LOGIC;
           o_actorSetPos_X_we : out STD_LOGIC;
           o_actorSetPos_Y_we : out STD_LOGIC;
           o_actorSetActive_we : out STD_LOGIC;
           o_actorSetTile_we : out STD_LOGIC;
           o_backgroundTile_XY_we : out STD_LOGIC;
           -- o_backgroundTile_X_we : out STD_LOGIC;
           -- o_backgroundTile_Y_we : out STD_LOGIC;
           o_actorBuffer_we : out STD_LOGIC);
end Control;

architecture Behavioral of Control is
type decoded_opcode_type is (
    ACTOR_SET_POS_X,
    ACTOR_SET_POS_Y,
    ACTOR_SET_POS_XY,
    ACTOR_SET_ACTIVE,
    ACTOR_SET_TILE,
    BACKGROUND_TILE_SET_XY,
    UNDEFINED
);
signal DECODED_OPCODE : decoded_opcode_type := UNDEFINED; 
begin
    process(i_opcode) begin
        case (i_opcode) is
          when "01001" =>
             DECODED_OPCODE <= ACTOR_SET_POS_X;
          when "01010" =>
             DECODED_OPCODE <= ACTOR_SET_POS_Y;
          when "01011" =>
             DECODED_OPCODE <= ACTOR_SET_POS_XY;
          when "00110" =>
             DECODED_OPCODE <= ACTOR_SET_ACTIVE;
          when "01000" =>
             DECODED_OPCODE <= ACTOR_SET_TILE;
          when "00001" =>
             DECODED_OPCODE <= BACKGROUND_TILE_SET_XY;
          when others =>
             DECODED_OPCODE <= UNDEFINED;
       end case;
    end process;
    o_actorSetPos_X_we      <= '1' when i_opcode = "01001" else '0';
    o_actorSetPos_Y_we      <= '1' when i_opcode = "01010" else '0';
    o_actorSetPos_XY_we     <= '1' when i_opcode = "01011" else '0';
    o_actorSetActive_we     <= '1' when i_opcode = "00110" else '0';
    o_actorSetTile_we       <= '1' when i_opcode = "01000" else '0';
    o_backgroundTile_XY_we  <= '1' when i_opcode = "00001" else '0';
    o_actorBuffer_we <= '0';
    -- o_backgroundTile_X_we   <= '1' when i_opcode = "00010" else '0';
    -- o_backgroundTile_Y_we   <= '1' when i_opcode = "00011" else '0';
end Behavioral;
