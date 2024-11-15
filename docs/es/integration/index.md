# Integración con GeoNode

!!! warning

     Integración experimental de GeoNode en GeoServer Cloud

## Configurar AuthZN de GeoNode

1. Accede a [http://localhost/geoserver/](http://localhost/geoserver/) (nota la barra `/` al final).

    !!! note

    Reemplaza localhost con el DNS de tu implementación de GeoNode, si corresponde.

2. Inicia sesión como `admin/geoserver`.

### Crear servicio de ROL

1. Navega hasta **Seguridad** -> **Usuarios, Grupos, Roles** -> **Servicios** -> **Servicios de Rol/Nuevo Servicio**.
2. Selecciona **AuthKEY REST**.
3. Establece los siguientes valores:
    - **Name**: `servicio de rol REST de geonode`
    - **Base Server URL**: `http://django:8000/`
4. Guardar.

### Configurar la cadena de filtros de seguridad OAuth2 de GeoNode

1. Accede a **Seguridad** -> **Autenticación** -> **Nuevo filtro de autenticación** -> **GeoNode Oauth2**.
2. Usa las siguientes configuraciones:
    - **User Authorization URI**: `http://localhost/o/authorize/`
    - **Access Token URI**: `http://django:8000/o/token/`
    - **Redirect URI**: `http://localhost/geoserver/index.html`
    - **Check Token Endpoint URL**: `http://django:8000/api/o/v4/tokeninfo/`
    - **Logout URI**: `http://localhost/account/logout/`
    - **Scopes**: `write`
    - **Client ID**: `geonode`
    - **Client Secret**: `geonodesecret`
    - **ROLE Service**: `geonode REST role service`
3. Guardar.

4. Accede a **Cadenas de Filtros** y añade la cadena de filtros `geonode` a las cadenas **web**, **rest**, **gwc** y **default** **BEFORE** (arriba de) la `gateway-shared-auth`.
5. Guardar.

6. Cierra sesión. Ahora deberías ver el botón de **Inicio de sesión con GeoNode** en el encabezado de la página web de GeoServer.

Ahora, inicia sesión con `geonode`, y debería funcionar como de costumbre.

## Crear Espacio de Trabajo y Almacén de Datos

### Crear Espacio de Trabajo

1. Accede a **Espacios de Trabajo** y haz clic en **Añadir nuevo espacio de trabajo**.
2. Introduce la siguiente información:
    - **Name**: `geonode`
    - **Namespace URI**: `http://www.geonode.org/`
    - Marca la casilla para **Default workspace**.
3. Guardar.

### Crear Almacén de Datos

1. Ve a **Almacenes** y selecciona **Añadir nuevo Almacén** -> **PostGIS**.
2. Rellena los siguientes detalles:

   Información Básica del Almacén:

   - **Workspace**: `geonode`
   - **Data Source Name**: `geonode_data`
   - **Enabled**: Marca esta casilla.

   Parámetros de Conexión:

   - **host**: `gndatabase`
   - **port**: `5432`
   - **database**: `geonode_data`
   - **schema**: `public`
   - **user**: `geonode_data`
   - **password**: `geonode_data`
   - **Namespace**: `http://www.geonode.org/`
   - **max connections**: `10`

3. Opcionalmente, marca **Expose primary keys**, si es necesario.
4. Haz clic en **Guardar**.
