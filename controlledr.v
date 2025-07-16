


wire [17:6] leds_derrota_out;

leds_derrota u_leds_derrota (
    .derrota(derrota),
    .led_out(leds_derrota_out)
);



assign LEDR = (senha_correta) ? leds_vitoria_out :
              (derrota)       ? leds_derrota_out;  // pode ser dica, bits corretos etc.
