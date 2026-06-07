# Mac Workspace Config

Automacao de workspace no macOS com Hammerspoon, incluindo wallpapers por Space.

## Features

- Wallpaper por Space (tema por desktop)
- Aplicacao de wallpaper tematico apenas no monitor externo
- Prioriza o monitor principal quando ele for externo
- Auto reload da configuracao do Hammerspoon
- Atalho de lock de tela com `Cmd+L`
- Script para gerar wallpapers em lote

## Requisitos

- macOS
- Hammerspoon instalado
- Permissoes de Accessibility e Automation para o Hammerspoon

## Install

```bash
git clone https://github.com/uriasfernandes/mac-workspace-config.git
cd mac-workspace-config
make install
```

Depois, abra o Hammerspoon e recarregue a configuracao.

## Como Funciona

O script principal de wallpapers fica em [hammerspoon/spaces-wallpaper.lua](hammerspoon/spaces-wallpaper.lua).

Mapeamento padrao de tema por Space:

- Space 1: `~/Pictures/wallpapers/1-pessoal.png`
- Space 2: `~/Pictures/wallpapers/2-trabalho.png`
- Space 3: `~/Pictures/wallpapers/3-finops.png`
- Space 4: `~/Pictures/wallpapers/4-devops-k8s.png`
- Space 5: `~/Pictures/wallpapers/5-devops-vault.png`
- Space 6: `~/Pictures/wallpapers/6-devops-ia.png`
- Space 7: `~/Pictures/wallpapers/7-bot.png`

Para Spaces acima dos mapeados, o fallback esperado e:

- `~/Pictures/wallpapers/wallpaper-<indice-do-space>.png`

## Comportamento em Multi-Monitor

Importante:
as trocas de wallpaper por tema sao aplicadas somente no monitor externo detectado.

Quando o Mac estiver conectado em monitor externo:

- o wallpaper tematico e aplicado apenas no monitor externo
- a tela interna do Mac nunca recebe esses wallpapers tematicos
- o indice de Space usado para decidir o tema e lido apenas no monitor externo alvo
- se o monitor principal atual for externo, ele e usado como alvo

Quando nao houver monitor externo conectado, o script ignora a troca tematica.

## Geracao de Wallpapers

O gerador permite ajustar resolucao para combinar com o monitor externo e evitar texto desproporcional.

Variaveis suportadas:

- `WIDTH` e `HEIGHT`: resolucao de saida
- `TEXT_SCALE_PERCENT`: escala do texto (100 = padrao)
- `TEXT_MARGIN_X` e `TEXT_MARGIN_Y`: margem horizontal/vertical a partir do canto inferior esquerdo
- `TEXT_EDGE_PADDING`: padding tecnico para evitar clipping do contorno do texto na borda

Exemplo padrao:

```bash
wallpapers/generate-wallpapers.sh
```

Exemplo com resolucao customizada:

```bash
WIDTH=3440 HEIGHT=1440 wallpapers/generate-wallpapers.sh
```

Exemplo usado no ajuste atual (texto menor no canto inferior esquerdo):

```bash
WIDTH=2560 HEIGHT=1080 TEXT_SCALE_PERCENT=80 TEXT_MARGIN_X=0 TEXT_MARGIN_Y=0 wallpapers/generate-wallpapers.sh
```

Sugestao: gere sempre com a resolucao nativa do monitor externo atual.

## Estrutura

- [hammerspoon/init.lua](hammerspoon/init.lua): bootstrap, reload automatico e hotkey
- [hammerspoon/spaces-wallpaper.lua](hammerspoon/spaces-wallpaper.lua): logica de Spaces e wallpapers
- [wallpapers/generate-wallpapers.sh](wallpapers/generate-wallpapers.sh): geracao de imagens

## Troubleshooting

- Se o wallpaper nao trocar, valide permissoes do Hammerspoon no macOS.
- Se der erro de arquivo nao encontrado, confira os caminhos em `~/Pictures/wallpapers`.
- Se a configuracao nao recarregar, use o menu do Hammerspoon e clique em Reload Config.
