library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity color_converter is
    Port ( code     : in STD_LOGIC_VECTOR (3 downto 0);
           color    : out STD_LOGIC_VECTOR (23 downto 0));
end color_converter;

architecture Behavioral of color_converter is

begin
    color <= 
            x"C85087" when code = x"0"  else    -- transparent
            x"000000" when code = x"1"  else    -- noire              
            x"FFFFFF" when code = x"2"  else    -- blanc              
            x"00A2E8" when code = x"3"  else    -- bleu pale  
            x"ED1A2C" when code = x"4"  else    -- rouge       
            x"C85086" when code = x"5"  else    -- rose              
            x"F7AB79" when code = x"6"  else    -- beige               
            x"B5E61D" when code = x"7"  else    -- lime            
            x"0c6624" when code = x"8"  else    -- vert foret   
            x"22b14c" when code = x"0"  else    -- vert buisson 
            x"8A5132" when code = x"A"  else    -- brun         
            x"FF7F2F" when code = x"B" else     -- orange       
            x"FFF200" when code = x"C" else     -- jaune        
            x"7a767a" when code = x"D" else     -- gris         
            x"2121B8" when code = x"E" else     -- bleu fonce    
            x"C85087" when code = x"F" else     -- undefined    
            x"C85087";    
end Behavioral;
