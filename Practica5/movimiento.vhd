library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Este codigo controla el movimiento de un servomotor SG90 ajustando 
--el "ancho" de pulso en un rango entre 55 y 95, que corresponde a ángulos 
--de rotación entre 0° y 180°.[2]

--Declaramos la entidad movimiento [3]
entity movimiento is 
    --pi y pf establecen posiciones fijas, 
    --inc y dec permiten incrementos o decrementos en pasos pequeños
    --Usa un reloj para generar pulsos de control cada 1 ms. [1]
    port(
        clk, pi, pf, inc, dec, rst: in std_logic;
        ancho: out integer
    );
end entity;

--Definimos la arquitectura arqmov de movimiento
architecture arqmov of movimiento is
    -- Puede tomar valores entre 0 y 200, con un valor inicial de 75. 
    -- Este valor suele representar un parámetro ajustable,
    -- como el ciclo de trabajo para controlar la posición del servomotor. [1]
    signal valor: integer range 0 to 200 := 75;
    
    -- Es un contador que puede tomar valores de 0 a 50000, 
    -- comenzando en 0. Se utiliza para contar ciclos de reloj y generar retardos temporales.
    signal contador: integer range 0 to 50000 := 0; 
    
    -- Controla el incremento/decremento
    signal en: std_logic := '0';
    
begin
    process (clk, rst)
    begin
        -- **Ejercicio 5.5**: Si rst (reset) es activado, el valor del pulso (valor) 
        -- se reinicia a 75 (~1.5 ms), el contador a 0, y se deshabilita el movimiento.
        if rst = '1' then
            valor <= 75;
            contador <= 0;
            en <= '0';
        
        -- En cada ciclo de reloj (rising_edge(clk)), el contador se incrementa 
        -- hasta alcanzar 5000 (equivalente a 1 ms con un reloj de 50 MHz). 
        -- Entonces, la señal enable se activa.
        elsif rising_edge(clk) then
            if contador = 5000 then  
                contador <= 0;
                en <= '1';
            else
                contador <= contador + 1;
                en <= '0';
            end if;
            
            -- Si enable = '1', se ajusta valor según las señales de entrada:
            if en = '1' then
                -- **Ejercicio 5.1**: Ir directamente al extremo inferior (~1 ms, 55)
                if pi = '1' then
                    valor <= 55;  
                
                -- **Ejercicio 5.2**: Ir directamente al extremo superior (~2 ms, 95)
                elsif pf = '1' then 
                    valor <= 95;  
                
                -- **Ejercicio 5.3**: Aumentar en el orden de una décima (5.5, 5.6, 5.7, …) 
                -- (Aumenta de 1 en 1 en esta implementación)
                elsif inc = '1' and valor < 95 then
                    valor <= valor + 1;
                
                -- **Ejercicio 5.4**: Disminuir en el orden de una décima (9.5, 9.4, 9.3, …) 
                -- (Disminuye de 1 en 1 en esta implementación)
                elsif dec = '1' and valor > 55 then
                    valor <= valor - 1;
                end if;
            end if;
        end if;
        ancho <= valor; -- Asignación continua de `ancho` al valor calculado
    end process;
end architecture;
