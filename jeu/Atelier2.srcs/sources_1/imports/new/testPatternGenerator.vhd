----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2021 06:55:22 PM
-- Design Name: 
-- Module Name: testPatternGenerator - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testPatternGenerator is
Port ( 
    clk : in std_logic;
    rstn : in std_logic;
    m_axis_tuser : out std_logic;
    m_axis_tlast : out std_logic;
    m_axis_tvalid : out std_logic;
    m_axis_tdata : out std_logic_vector(23 downto 0);
    m_axis_tready : in std_logic;
    i_colorDataA : in std_logic_vector(31 downto 0);
    i_colorDataB : in std_logic_vector(31 downto 0)
);
end testPatternGenerator;

architecture Behavioral of testPatternGenerator is

type state_videostr is (WAITING, STREAMING, EOL);
signal lineCpt : unsigned(11 downto 0) := (others => '0');
signal columnCpt : unsigned(11 downto 0) := (others => '0');
signal pixelXCpt : unsigned(3 downto 0) := (others => '0');
signal pixelYCpt : unsigned(3 downto 0) := (others => '0');
signal current_state : state_videostr := WAITING;
signal next_state : state_videostr := WAITING;

component tileBgBuffer is
    Port ( 
            clk : in std_logic;
            pixel_X : in STD_LOGIC_VECTOR (7 downto 0);
            pixel_Y : in STD_LOGIC_VECTOR (7 downto 0);
            tileId : in STD_LOGIC_VECTOR (7 downto 0);
            colorCode : out STD_ULOGIC_VECTOR (3 downto 0));
           
end component;

component color_converter is
    Port ( code     : in STD_ULOGIC_VECTOR (3 downto 0);
           color    : out STD_LOGIC_VECTOR (23 downto 0));
end component;

signal s_code : std_Ulogic_vector (3 downto 0);
signal s_color: std_logic_vector (23 downto 0);
signal s_tileId_index: unsigned(7 downto 0) := (others => '0');
signal s_timer: unsigned(15 downto 0) := (others => '0');

begin

inst_color_converter: color_converter
    port map(
        code => s_code,
        color => m_axis_tdata
    );
    
inst_buffer: tileBgBuffer 
Port map(
 clk         => clk,
 pixel_X     => std_logic_vector(columnCpt(7 downto 0)),
 pixel_Y     => std_logic_vector(lineCpt(7 downto 0)),
 tileId      => std_logic_vector(s_tileId_index),
colorCode    => s_code
);

process(clk)
begin
    if(rstn = '0') then
        current_state <= WAITING;
    elsif(rising_edge(clk)) then
        current_state <= next_state;
        if(m_axis_tready = '1') then             
             if(columnCpt = "000100000000") then
                    columnCpt <= "000000000000";
                    -- pixelXCpt <= "0000";               
                    
                    if(lineCpt = "000011100000") then
                        lineCpt  <= "000000000000";
                        -- pixelYCpt <= "0000";
--                        if(s_timer = "0001111111111111") then
--                            s_timer <= "0000000000000000";
--                            if(s_tileId_index = "00011001") then
--                                s_tileId_index <= "00000000";
--                            else
--                                s_tileId_index <= s_tileId_index + "1";
--                            end if;
--                        else
--                            s_timer <= s_timer + "1";
--                        end if;
                    else
--                        if(pixelYCpt = "1111") then 
--                           pixelYCpt <= "0000";
--                        else
--                           pixelYCpt <= pixelYCpt + "1";
--                        end if;
                        lineCpt <= lineCpt + "1";
                    end if;
             else
--                 if(pixelXCpt = "1111") then 
--                    pixelXCpt <= "0000";
--                 else
--                    pixelXCpt <= pixelXCpt + "1";
--                 end if;
                columnCpt <= columnCpt + "1";
             end if;
         end if;
    end if;
end process;

process(current_state, m_axis_tready,columnCpt,lineCpt)
begin
    case current_state is
    when WAITING =>
        if(m_axis_tready = '1') then
            next_state <= STREAMING;
        else
            next_state <= WAITING;
        end if;
    when STREAMING =>
        if(columnCpt = "00011111111") then
            next_state <= EOL;
        else
            next_state <= STREAMING;
        end if;
    when EOL =>
         if(lineCpt = "00011011111") then
            next_state <= WAITING;
         else
            next_state <= STREAMING;
         end if;
    end case;
end process;
  
process(current_state,lineCpt)
begin
    case current_state is
    when WAITING =>
        m_axis_tvalid <= '1';
        m_axis_tuser <= '1';
        m_axis_tlast <= '0';
    when STREAMING =>
        m_axis_tvalid <= '1';
        m_axis_tlast <= '0';
        m_axis_tuser <= '0';
    when EOL =>
        m_axis_tvalid <= '1';
        m_axis_tlast <= '1';
        m_axis_tuser <= '0';
    end case;
    
    -- if(lineCpt(0) = '1') then
     --   m_axis_tdata <= i_colorDataA(23 downto 0);
     --else 
     --   m_axis_tdata <= i_colorDataB(23 downto 0);
     --end if;         
end process;     
--process(clk, i_colorDataB)
--begin
--    if(clk) then
--    end if;
--end process;

end Behavioral;
