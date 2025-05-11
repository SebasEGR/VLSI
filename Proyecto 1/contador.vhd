library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Definición de la entidad 'contador'
entity contador is
    port (
        echo, clkl1, rst: in std_logic;  -- Entradas: 'echo' (señal de eco), 'clkl1' (reloj de entrada), 'rst' (reset)
        salida0, salida1, dis: out integer  -- Salidas: 'salida0', 'salida1' (decenas y unidades) y 'dis' (distancia)
    );
--    inc, dec: out std_logic);  -- Las señales de incremento y decremento se comentan porque no se están utilizando
end entity;

-- Definición de la arquitectura 'arqcontador' de la entidad 'contador'
architecture arqcontador of contador is
    signal conteo: integer range 0 to 12000;  -- Señal interna para contar hasta 12000
begin

    -- Proceso sensible a las señales 'echo', 'clkl1' y 'rst'
    process(echo, clkl1, rst)
        variable decena: integer;   -- Variable para almacenar la parte de las decenas de la distancia
        variable unidad: integer;   -- Variable para almacenar la parte de las unidades de la distancia
        variable modulo: integer;   -- Variable para almacenar el módulo de 'conteo' con 59
    begin
    
        -- Condición que se activa en el flanco ascendente de 'clkl1'
        if rising_edge(clkl1) then
        
            -- Condición de reset: si 'rst' está activo, reinicia el contador
            if(rst = '1') then
                conteo <= 0;  -- Si el reset está activo, el contador se pone a 0
            -- Segunda condición de flanco ascendente de 'clkl1' (esto parece innecesario, ya que se usa en el mismo proceso)
            elsif(rising_edge(clkl1)) then
            
                -- Si 'echo' está activo (es 1), incrementa el contador
                if(echo = '1') then
                    conteo <= conteo + 1;  -- Si 'echo' es 1, aumenta el contador en 1
                else
                    -- Si 'echo' es 0, realiza el cálculo con 'conteo'
                    modulo := conteo mod 59;  -- Calcula el módulo de 'conteo' con 59
                    
                    -- Si 'conteo' está fuera del rango 30 a 5841, reinicia el contador
                    if(conteo < 30 or conteo > 5841) then
                        conteo <= 0;  -- Reinicia el contador si está fuera de este rango
                    else
                        -- Si 'conteo' es múltiplo de 59, no hace nada
                        if(modulo = 0) then
                            conteo <= conteo;
                        -- Si 'modulo' es mayor o igual a 30, incrementa el contador
                        elsif(modulo >= 30) then
                            conteo <= conteo + (modulo - 1);
                        -- Si 'modulo' es menor a 30, decrementa el contador
                        elsif((conteo mod 59) < 30) then
                            conteo <= conteo - (modulo - 1);
                        end if;
                    end if;
                    
                    -- Calcula las decenas y unidades de 'conteo'
                    decena := integer((conteo/59)/10);  -- Calcula las decenas
                    unidad := (conteo/59)-(decena * 10);  -- Calcula las unidades
                    
                    -- Asigna las salidas con los valores calculados
                    salida0 <= decena;  -- Asigna la parte de las decenas a 'salida0'
                    salida1 <= unidad;  -- Asigna la parte de las unidades a 'salida1'
                    dis <= (conteo/59);  -- Asigna el valor total dividido por 59 a 'dis'
                end if;
            end if;
        end if;
        
    end process;
end architecture;
