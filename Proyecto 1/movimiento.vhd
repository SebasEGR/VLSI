library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Entidad que controla el movimiento de un motor mediante PWM y captura de valores para display
entity movimiento is
    port (
        clk, reset, take        : in std_logic;         -- clk: reloj, reset: reinicio del sistema, take: señal para capturar valores
        valor_distancia         : in integer;           -- valor_distancia: entrada que define el objetivo del PWM
        salida2, salida3        : in integer;           -- entradas no usadas internamente (pueden venir del display para visualizar)
        ancho, ss2, ss3         : out integer           -- ancho: valor PWM actual, ss2 y ss3: valores capturados (decenas y unidades)
    );
end entity;

architecture arqmov of movimiento is
    -- Señales internas
    signal pwm        : integer range 55 to 95 := 55;     -- Valor actual de PWM (inicia en 55)
    signal contador   : integer range 0 to 50000 := 0;    -- Contador para controlar la frecuencia de actualización
    signal en         : std_logic := '0';                 -- Señal de habilitación temporizada
    signal pwm_target : integer := 55;                    -- Valor objetivo del PWM (según la distancia)

    -- Señales para capturar el valor del PWM en decenas y unidades cuando 'take' = '0'
    signal capturado_decena  : integer range 0 to 9 := 0;
    signal capturado_unidad  : integer range 0 to 9 := 0;

begin

    process (clk, reset)
    begin
        -- Reinicio del sistema: se inicializan todas las señales a sus valores base
        if reset = '1' then
            pwm <= 55;
            pwm_target <= 55;
            contador <= 0;
            en <= '0';
            capturado_decena <= 0;
            capturado_unidad <= 0;

        -- Operación normal en flanco de subida del reloj
        elsif rising_edge(clk) then

            -- Si la señal 'take' está en '0', se captura el valor actual de pwm_target
            if take = '0' then
                capturado_decena <= pwm_target / 10;
                capturado_unidad <= pwm_target mod 10;
            end if;

            -- Temporizador: habilita la actualización cada 5000 ciclos
            if contador = 5000 then
                contador <= 0;
                en <= '1';
            else
                contador <= contador + 1;
                en <= '0';
            end if;

            -- Asignación del objetivo de PWM dependiendo del valor de distancia
            case valor_distancia is
                when 0 => pwm_target <= 95;
                when 1 => pwm_target <= 90;
                when 2 => pwm_target <= 85;
                when 3 => pwm_target <= 80;
                when 4 => pwm_target <= 75;
                when 5 => pwm_target <= 70;
                when 6 => pwm_target <= 65;
                when 7 => pwm_target <= 60;
                when 8 => pwm_target <= 55;
                when 9 => pwm_target <= 55;
                when others => pwm_target <= 55;  -- Valor por defecto
            end case;

            -- Ajuste gradual del valor de PWM hacia el objetivo (pwm_target)
            if pwm < pwm_target then
                pwm <= pwm + 1;
            elsif pwm > pwm_target then
                pwm <= pwm - 1;
            end if;
        end if;
    end process;

    -- Asignación de salidas
    ancho <= pwm;                       -- Salida PWM actual al motor
    ss2 <= capturado_decena;           -- Parte de las decenas del PWM capturado (display 2)
    ss3 <= capturado_unidad;           -- Parte de las unidades del PWM capturado (display 3)

end architecture;
