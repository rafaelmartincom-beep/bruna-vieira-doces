# Bruna Vieira Doces Finos

App de precificação e cadastro de receitas da Bruna Vieira Doces Finos.

- Ingredientes com preço pago e tamanho da embalagem
- Receitas com categoria, rendimento, durabilidade, dificuldade e modo de preparo
- Precificação: custos fixos, utensílios e embalagem, mão de obra (% ou por hora), lucro e taxa de venda
- Lista de compras a partir da quantidade de doces
- Orçamentos para clientes, com PDF que leva o logo no cabeçalho e no rodapé
- Login por e-mail e senha, com "esqueci minha senha"
- Instalável no celular (Adicionar à tela inicial)

Site estático (HTML, CSS e JavaScript, sem build). Dados e login no Supabase. Hospedagem na Cloudflare (Workers & Pages).

## Arquivos

| Arquivo | Para que serve |
|---|---|
| `index.html` | O app inteiro |
| `config.js` | URL e chave pública do Supabase |
| `supabase/schema.sql` | Cria todas as tabelas e as regras de acesso |
| `supabase/orcamentos.sql` | Só a tabela de orçamentos (para quem já rodou o schema antes) |
| `img/` | Logo usado no PDF do orçamento |
| `manifest.webmanifest`, `sw.js`, `icons/` | Deixam o app instalável no celular |

## Colocar no ar

1. **Chave do Supabase.** No painel do projeto, clique em **Connect** (topo da tela) ou vá em
   **Project Settings > API Keys**. Copie a chave **publishable** (`sb_publishable_...`) ou, na aba
   *Legacy API keys*, a **anon public**. Cole em `config.js`, no lugar de `COLE_AQUI_A_CHAVE_PUBLICA`.
   Nunca use a chave *secret* / *service_role*.
2. **Banco.** No Supabase, **SQL Editor > New query**, cole `supabase/schema.sql` e clique em **Run**.
3. **Vercel.** Em vercel.com, entre com o GitHub, **Add New > Project**, escolha este repositório
   e clique em **Deploy** (não precisa mudar nenhuma configuração).
4. **Endereço do site no Supabase.** Em **Authentication > URL Configuration**, coloque o endereço
   da Vercel (ou o domínio próprio) em **Site URL** e também em **Redirect URLs**. Sem isso, os
   links de confirmação e de nova senha que chegam por e-mail não voltam para o app.
5. **Primeiro acesso.** Abra o site, toque em **Criar conta**, confirme pelo e-mail e entre.
6. **Fechar cadastro.** Depois de criar as contas que vão usar o app, desligue
   **Authentication > Sign In / Providers > Allow new users to sign up**, para ninguém mais criar conta.

## Domínio próprio

Registre o domínio no Registro.br. Na Vercel, abra o projeto > **Settings > Domains**, adicione o
domínio e copie os registros DNS que ela mostrar para o painel do Registro.br. Depois atualize a
Site URL do passo 4 com o domínio novo.
