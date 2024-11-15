# GeoNode integration

!!! warning

    GeoServer Cloud experimental GeoNode integration

## Configure GeoNode AuthZN

1. Go to [http://localhost/geoserver/](http://localhost/geoserver/) (note the trailing `/`).

   !!! note

       Replace localhost with the DNS of your GeoNode deployment if applicable.

2. Log in as `admin/geoserver`.

!!! note

### Create ROLE service

1. Navigate to **Security** -> **Users, Groups, Roles** -> **Services** -> **Role Services/Add New**.
2. Select **AuthKEY REST**.
3. Set the following values:
    - **Name**: `geonode REST role service`
    - **Base Server URL**: `http://django:8000/`
4. Save.

### Set up GeoNode OAuth2 security filter chain

1. Go to **Security** -> **Authentication** -> **New auth filter** -> **GeoNode Oauth2**.
2. Use the following settings:
    - **User Authorization URI**: `http://localhost/o/authorize/`
    - **Access Token URI**: `http://django:8000/o/token/`
    - **Redirect URI**: `http://localhost/geoserver/index.html`
    - **Check Token Endpoint URL**: `http://django:8000/api/o/v4/tokeninfo/`
    - **Logout URI**: `http://localhost/account/logout/`
    - **Scopes**: `write`
    - **Client ID**: `geonode`
    - **Client Secret**: `geonodesecret`
    - **ROLE Service**: `geonode REST role service`
3. Save.

4. Go to **Filter Chains**, and add the `geonode` filter chain to the **web**, **rest**, **gwc**, and **default** chains **BEFORE** (above) the `gateway-shared-auth` one.
5. Save.

6. Logout. You should see the **GeoNode login** button now in the GeoServer web UI page header.

Now, log in with `geonode`, and it should work as usual.

## Create Workspace and Data Store

### Create Workspace

1. Go to **Workspaces** and click on **Add new workspace**.
2. Enter the following information:
    - **Name**: `geonode`
    - **Namespace URI**: `http://www.geonode.org/`
    - Check the box for **Default workspace**.
3. Save.

### Create Data Store

1. Go to **Stores** and select **Add new Store** -> **PostGIS**.
2. Fill in the following details:

   Basic Store Information:

   - **Workspace**: `geonode`
   - **Data Source Name**: `geonode_data`
   - **Enabled**: Check this box.

   Connection Parameters:

   - **host**: `gndatabase`
   - **port**: `5432`
   - **database**: `geonode_data`
   - **schema**: `public`
   - **user**: `geonode_data`
   - **password**: `geonode_data`
   - **Namespace**: `http://www.geonode.org/`
   - **max connections**: `10`

3. Optionally, check **Expose primary keys** if needed.
4. Click **Save**.
