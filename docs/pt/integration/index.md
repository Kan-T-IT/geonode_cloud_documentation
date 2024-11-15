# Integração com o GeoNode

!!! warning

    Integração experimental GeoNode no GeoServer Cloud

## Configurar AuthZN do GeoNode

1. Acesse [http://localhost/geoserver/](http://localhost/geoserver/) (note a barra `/` no final).

    !!! note

    Substitua localhost pelo DNS da sua implantação do GeoNode, se aplicável.

2. Faça login como `admin/geoserver`.

### Criar serviço de PAPEL (ROLE)

1. Navegue até **Segurança** -> **Usuários, Grupos, Papéis** -> **Serviços** -> **Serviços de Papel/Novo Serviço**.
2. Selecione **AuthKEY REST**.
3. Defina os seguintes valores:
    - **Name**: `geonode REST role service`
    - **Base Server URL**: `http://django:8000/`
4. Salvar.

### Configurar cadeia de filtros de segurança OAuth2 do GeoNode

1. Vá para **Segurança** -> **Autenticação** -> **Novo filtro de autenticação** -> **GeoNode Oauth2**.
2. Use as seguintes configurações:
    - **User Authorization URI**: `http://localhost/o/authorize/`
    - **Access Token URI**: `http://django:8000/o/token/`
    - **Redirect URI**: `http://localhost/geoserver/index.html`
    - **Check Token Endpoint URL**: `http://django:8000/api/o/v4/tokeninfo/`
    - **Logout URI**: `http://localhost/account/logout/`
    - **Scopes**: `write`
    - **Client ID**: `geonode`
    - **Client Secret**: `geonodesecret`
    - **ROLE Service**: `geonode REST role service`
3. Salvar.

4. Acesse **Cadeias de Filtros** e adicione a cadeia de filtros `geonode` às cadeias **web**, **rest**, **gwc** e **default** **ANTES** (acima) da `gateway-shared-auth`.
5. Salvar.

6. Faça logout. Agora você deve ver o botão **Login do GeoNode** no cabeçalho da página da interface web do GeoServer.

Agora, faça login com `geonode`, e ele deve funcionar normalmente.

## Criar Espaço de Trabalho e Armazenamento de Dados

### Criar Espaço de Trabalho

1. Acesse **Espaços de Trabalho** e clique em **Adicionar novo espaço de trabalho**.
2. Insira as seguintes informações:
    - **Name**: `geonode`
    - **Namespace URI**: `http://www.geonode.org/`
    - Marque a caixa para **Default workspace**.
3. Salvar.

### Criar Armazenamento de Dados

1. Vá para **Armazenamentos** e selecione **Adicionar novo Armazenamento** -> **PostGIS**.
2. Preencha os seguintes detalhes:

   Informações Básicas do Armazenamento:

   - **Workspace**: `geonode`
   - **Data Source Name**: `geonode_data`
   - **Enabled**: Marque esta caixa.

   Parâmetros de Conexão:

   - **host**: `gndatabase`
   - **port**: `5432`
   - **database**: `geonode_data`
   - **schema**: `public`
   - **user**: `geonode_data`
   - **password**: `geonode_data`
   - **Namespace**: `http://www.geonode.org/`
   - **max connections**: `10`

3. Opcionalmente, marque **Expose primary keys**, se necessário.
4. Clique em **Save**.
