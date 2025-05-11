library ieee;
use ieee.std_logic_1164.all;

-- Definición de la entidad 'trigger'
entity trigger is
    port (
        clk, rst, echo: in std_logic;   -- Entradas: clk (reloj), rst (reset), echo (señal de eco)
        salida: out std_logic            -- Salida: 'salida' que es una señal de control
    );  
end entity;

-- Definición de la arquitectura 'arqtrigger' de la entidad 'trigger'
architecture arqtrigger of trigger is
begin

    -- Proceso sensible a 'clk', 'rst' y 'echo'
    process(clk, rst, echo)
    begin
    
        -- Condición de reset
        if(rst = '1') then  
            salida <= '0';  -- Si reset está activado, la salida se pone a 0
        -- Condición cuando 'echo' es 0
        elsif(echo = '0') then  
            salida <= clk;  -- Si 'echo' es 0, la salida sigue el estado del reloj 'clk'
        end if;
        
    end process;
end architecture;
