# Armazenamento de anexos

## Provedor interno

O provedor padrão usa o bucket privado `financial-attachments` do Supabase. O
download passa por uma rota autenticada, valida o vínculo do usuário com a
empresa e gera uma URL assinada curta. Assim, os arquivos persistem entre
redeploys do contêiner e nunca precisam ser publicados.

## Google Drive

1. No Google Cloud, ative a Google Drive API.
2. Configure a tela de consentimento OAuth.
3. Crie um cliente OAuth do tipo **Aplicativo da Web**.
4. Cadastre exatamente:
   `https://financas.re9imob.com.br/api/storage/google/callback`.
5. Configure no servidor as quatro variáveis `GOOGLE_DRIVE_*` documentadas no
   `.env.example`.
6. Em **Configurações > Arquivos**, conecte e ative a conta desejada.

A aplicação solicita somente o escopo `drive.file`, cria/gerencia os arquivos
que ela própria enviou e não recebe acesso geral aos demais arquivos do Drive.
O refresh token é criptografado com AES-256-GCM antes de ir ao banco.

Trocar o provedor afeta somente novos uploads. Cada anexo registra o seu
provedor original e continua disponível pela mesma URL autenticada.
