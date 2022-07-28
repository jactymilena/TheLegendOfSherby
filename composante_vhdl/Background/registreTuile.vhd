
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.tuile_package.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity registreTuile is
    Port ( 
            clk : in std_ulogic;
            setTuileX : in STD_LOGIC_VECTOR (8 downto 0);
            setTuileY : in STD_LOGIC_VECTOR (8 downto 0);
            SetTileId : in STD_LOGIC_VECTOR (7 downto 0);
            
            colX      : in STD_LOGIC_VECTOR (4 downto 0) := "00000";
            rangerY   : in STD_LOGIC_VECTOR (4 downto 0)  := "00000";
	    bg_WE     : in std_logic := '1';
            tileId    : out STD_LOGIC_VECTOR (7 downto 0));
--            tuileX    : out std_logic_vector (8 downto 0);
--            tuileY    : out std_logic_vector (8 downto 0));
           
end registreTuile;
architecture Behavioral of registreTuile is
signal regTuileId : RegistreTileId := (
(signal regTuileId : RegistreTileId := (
(X"02", X"0b", X"01", X"0b", X"01",X"02", X"01", others => x"00"),
(X"03", X"04", others => x"05"),
(X"06", X"07", others => x"01"),
(X"08", X"09", others => x"0a"),
 others => (others => x"00")
 );

signal colonne, ranger : integer := 0;

begin
--entré
process(clk, SetTileId)
if clk='1' and clk'event then
    if(bg_WE = '1')then 
	regTuileId(to_integer(unsigned(setTuileX(8 downto 4))), to_integer(unsigned(setTuileY(8 downto 4)))) <= SetTileId;
 end if;
end if;
end process;


process(clk, rangerY, colX)
begin
--sortie
colonne <= TO_INTEGER(unsigned(colX));
ranger <= TO_INTEGER(unsigned(rangerY));
tileId <= regTuileId (TO_INTEGER(unsigned(rangerY)), TO_INTEGER(unsigned(colX)));


end process;
end Behavioral;
