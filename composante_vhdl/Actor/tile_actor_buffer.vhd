----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/21/2022 03:01:43 PM
-- Design Name: 
-- Module Name: tile_actor_buffer - Behavioral
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
use work.tuile_package.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tile_actor_buffer is
    Port ( i_pixel_x    : in STD_LOGIC_VECTOR  (3 downto 0);
           i_pixel_y    : in STD_LOGIC_VECTOR  (3 downto 0);
           i_tile_id    : in STD_LOGIC_VECTOR  (7 downto 0);
           o_color_code : out STD_ULOGIC_VECTOR (3 downto 0));
end tile_actor_buffer;

architecture Behavioral of tile_actor_buffer is

signal test : integer;
signal selected_tile : tableauCouleur;
signal tiles_buffer  : TuilesTableau := (
    (others=> x"0"),
    (others=> NOIR_CC), -- temp
    (others=> BLANC_CC), -- temp
    ( -- Coeur rouge
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, NOIR_CC, NOIR_CC, VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, NOIR_CC, NOIR_CC, VERT1_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, NOIR_CC, VERT1_CC, NOIR_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, NOIR_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, NOIR_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, NOIR_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, NOIR_CC, VERT1_CC,
        VERT1_CC, NOIR_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, NOIR_CC,
        VERT1_CC, NOIR_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, NOIR_CC,
        VERT1_CC, NOIR_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, NOIR_CC,
        VERT1_CC, VERT1_CC, NOIR_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, NOIR_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, NOIR_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, NOIR_CC, VERT1_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, NOIR_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, ROUGE_CC, ROUGE_CC, ROUGE_CC, NOIR_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, ROUGE_CC, NOIR_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC
    ), 
    ( -- Coeur rose
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, NOIR_CC, NOIR_CC, VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, NOIR_CC, NOIR_CC, VERT1_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, ROSE_CC, ROSE_CC, ROSE_CC, NOIR_CC, VERT1_CC, NOIR_CC, ROSE_CC, ROSE_CC, ROSE_CC, NOIR_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, NOIR_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, NOIR_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, NOIR_CC, VERT1_CC,
        VERT1_CC, NOIR_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, NOIR_CC,
        VERT1_CC, NOIR_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, NOIR_CC,
        VERT1_CC, NOIR_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, NOIR_CC,
        VERT1_CC, VERT1_CC, NOIR_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC,ROSE_CC, ROSE_CC, NOIR_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, NOIR_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, NOIR_CC, VERT1_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, ROSE_CC, NOIR_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, ROSE_CC, ROSE_CC, ROSE_CC, NOIR_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, ROSE_CC, NOIR_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC,
        VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, NOIR_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC, VERT1_CC
    ), 
    ( -- coffre
    x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, x"1", x"1", JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", JAUNE_CC, x"1"
	, x"1", JAUNE_CC, JAUNE_CC, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", JAUNE_CC, JAUNE_CC, x"1"
	, x"1", JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, JAUNE_CC, x"1"
	, x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1", x"1"), 
    others =>  (others => x"0")
);
begin
    process(i_pixel_x, i_pixel_y, i_tile_id)
    begin
        selected_tile <= tiles_buffer(to_integer(unsigned(i_tile_id)));
        o_color_code <= selected_tile(to_integer(unsigned(i_pixel_y))* 16 + to_integer(unsigned(i_pixel_x)));
    end process;
    
    

end Behavioral;
