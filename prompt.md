# Prompt de Documentacao - mac-workspace-config

Use este prompt para gerar ou revisar a documentacao do repositorio com foco no comportamento real da automacao de wallpapers no macOS.

## Prompt Base

Voce e um assistente tecnico de documentacao.

Objetivo:
Atualizar a documentacao do projeto mac-workspace-config para refletir o comportamento atual da automacao com Hammerspoon.

Contexto obrigatorio:
- O script principal de wallpaper esta em hammerspoon/spaces-wallpaper.lua.
- A troca de wallpaper por tema deve ocorrer somente em monitor externo.
- Se o monitor principal atual for externo, ele deve ser priorizado como alvo.
- A tela interna do Mac nunca deve receber os wallpapers tematicos.
- Se nao houver monitor externo, o script deve ignorar a troca.
- O gerador de wallpapers esta em wallpapers/generate-wallpapers.sh.
- O gerador aceita variaveis por ambiente: WIDTH, HEIGHT, TEXT_SCALE_PERCENT, TEXT_MARGIN_X, TEXT_MARGIN_Y e TEXT_EDGE_PADDING.

Entregaveis:
1. README objetivo com:
   - visao geral
   - features
   - comportamento em multi-monitor
   - instrucoes de instalacao e uso
   - troubleshooting
2. Secao de exemplos com comandos reais, incluindo:
   - wallpapers/generate-wallpapers.sh
   - WIDTH=3440 HEIGHT=1440 wallpapers/generate-wallpapers.sh
   - WIDTH=2560 HEIGHT=1080 TEXT_SCALE_PERCENT=80 TEXT_MARGIN_X=0 TEXT_MARGIN_Y=0 wallpapers/generate-wallpapers.sh
3. Linguagem direta, tecnica e sem ambiguidades.

Criterios de qualidade:
- Nao inventar funcionalidades.
- Nao omitir a regra de monitor externo.
- Incluir caminhos de arquivos reais do repositorio.
- Priorizar instrucoes reproduziveis.
