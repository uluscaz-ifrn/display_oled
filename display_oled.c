#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include "pico/stdlib.h"
#include "pico/binary_info.h"
#include "inc/ssd1306.h"
#include "hardware/i2c.h"

const uint I2C_SDA = 14;
const uint I2C_SCL = 15;

// Função para exibir a mensagem na tela
void ExibirMensagem(const char* mensagem) {
    uint8_t ssd[ssd1306_buffer_length];
    memset(ssd, 0, ssd1306_buffer_length);

    struct render_area frame_area = {
        .start_column = 0,
        .end_column = ssd1306_width - 1,
        .start_page = 0,
        .end_page = ssd1306_n_pages - 1
    };
    calculate_render_area_buffer_length(&frame_area);

    ssd1306_draw_string(ssd, 5, 12, mensagem);
    render_on_display(ssd, &frame_area);
}

// Definição dos pinos do LED RGB
#define LED_R_PIN 13
#define LED_G_PIN 11
#define LED_B_PIN 12
#define BTN_A_PIN 6

void SinalAberto() { 
    gpio_put(LED_R_PIN, 0); 
    gpio_put(LED_G_PIN, 1); 
    gpio_put(LED_B_PIN, 0); 
	ExibirMensagem("  SINAL ABERTO - ATRAVESSAR COM CUIDADO  ");
} 
 
void SinalAtencao() { 
    gpio_put(LED_R_PIN, 1); 
    gpio_put(LED_G_PIN, 1); 
    gpio_put(LED_B_PIN, 0); 
	ExibirMensagem("  SINAL DE ATENÇÃO - PREPARE-SE  ");
} 
 
void SinalFechado() { 
    gpio_put(LED_R_PIN, 1); 
    gpio_put(LED_G_PIN, 0); 
    gpio_put(LED_B_PIN, 0); 
	ExibirMensagem("  SINAL FECHADO - AGUARDE  ");
} 

// Funcao para verificar se o botao foi pressionado
int WaitWithRead(int delay_ms) {
    int button_state = 0;
    absolute_time_t timeout = make_timeout_time_ms(delay_ms);

    while (!time_reached(timeout)) {
        if (!gpio_get(BTN_A_PIN)) {  // Usando BTN_A_PIN que já está definido
            button_state = 1;
            break;
        }
        sleep_ms(10);
    }
    return button_state;
}

int main()
{
    stdio_init_all();   // Inicializa os tipos stdio padrão presentes ligados ao binário

    // Inicialização dos pinos do LED RGB
    gpio_init(LED_R_PIN);
    gpio_init(LED_G_PIN);
    gpio_init(LED_B_PIN);
    gpio_set_dir(LED_R_PIN, GPIO_OUT);
    gpio_set_dir(LED_G_PIN, GPIO_OUT);
    gpio_set_dir(LED_B_PIN, GPIO_OUT);

    gpio_init(BTN_A_PIN); 
    gpio_set_dir(BTN_A_PIN, GPIO_IN); 
    gpio_pull_up(BTN_A_PIN);

    // Inicialização do i2c
    i2c_init(i2c1, ssd1306_i2c_clock * 1000);
    gpio_set_function(I2C_SDA, GPIO_FUNC_I2C);
    gpio_set_function(I2C_SCL, GPIO_FUNC_I2C);
    gpio_pull_up(I2C_SDA);
    gpio_pull_up(I2C_SCL);

    // Processo de inicialização completo do OLED SSD1306
    ssd1306_init();

    // Preparar área de renderização para o display (ssd1306_width pixels por ssd1306_n_pages páginas)
    struct render_area frame_area = {
        start_column : 0,
        end_column : ssd1306_width - 1,
        start_page : 0,
        end_page : ssd1306_n_pages - 1
    };

    calculate_render_area_buffer_length(&frame_area);

    // zera o display inteiro
    uint8_t ssd[ssd1306_buffer_length];
    memset(ssd, 0, ssd1306_buffer_length);
    render_on_display(ssd, &frame_area);

    while (true) { 
        SinalAberto(); 
        int A_state = WaitWithRead(8000); 
 
        if (A_state) { 
            SinalAtencao(); 
            sleep_ms(5000); 
 
            SinalFechado(); 
            sleep_ms(10000); 
        } else { 
            SinalAtencao(); 
            sleep_ms(2000); 
 
            SinalFechado(); 
            sleep_ms(8000); 
        } 
    }

    return 0;
}
