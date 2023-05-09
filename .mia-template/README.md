# mia_template_service_name_placeholder

## Summary

%CUSTOM_PLUGIN_SERVICE_DESCRIPTION%

## Local development

First thing you need to do is install the dependencies. Enable Yarn running 

```sh
corepack enable
```

(or install it as a global dependency with `npm i -g yarn` for Node < 16.9.0), and run 

```sh
yarn install
```

Once you have the dependencies in place, run

```sh
yarn start
```

to spin up the application.

Tests can be run with

```sh
yarn coverage
```

## Use in micro-lc

Applications build with this template can be used as-is in micro-lc as [parcels](https://micro-lc.io/docs/guides/applications/parcels).

An example configuration may be:

```json5
{
  "applications": {
    "angular12-parcel": {
      "integrationMode": "parcel",
      "route": "./angular12-parcel/", // <-- must have the ending "/", should have the starting "."
      "entry": "/my-micro-lc-angular12-parcel/", // <-- must have the ending "/"
      "injectBase": true // <-- must be "true" if hash routing is not used
    }
  }
}
```

### Internal routing

The internal routing of the application is already set up to work in micro-lc, meaning that the base url of the internal
routes is dynamically computed on the bases of micro-lc `<base>`, as explained in the 
[official documentation](https://micro-lc.io/docs/guides/applications/parcels/#injectbase).

> 💡 **TIP**
>
> If you whish to use a hash router in your application, change `app-routing.module.ts` file as such:
> 
> ```diff
> - 17 imports: [RouterModule.forRoot(routes)],
> + 17 imports: [RouterModule.forRoot(routes, { useHash: true })],
> 
> - 19 providers: [{ provide: APP_BASE_HREF, useValue: baseUrl() }]
> + 19
> ```

### Assets

To correctly load assets in micro-lc, they should be put in `src/assets/` folder, and referenced using the `assetUrl`
[pipe](https://angular.io/guide/glossary#pipe).

A running example can be found in the `Home` component:

```html
<img alt="logo" class="app-logo" [src]="'angular-logo.svg' | assetUrl" />
```

### `zone.js`

Angular applications need [`zone.js`](https://github.com/angular/angular/tree/main/packages/zone.js) library to run, which
is not bundled in micro-lc. Therefore, you need to import it as a `<script>` in you micro-lc entrypoint **before** any
micro-lc related module.

```html
<!DOCTYPE html>
<html lang="en">

<head>

  [...]

  <script type="module" src="https://cdn.jsdelivr.net/npm/zone.js@0.13.0/dist/zone.min.js"></script>

  <script type="module" src="https://cdn.jsdelivr.net/npm/@micro-lc/orchestrator@latest/dist/micro-lc.production.js"></script>
</head>

[...]

</html>
```

> ⚠️ **Warning**
>
> `zone.js` is also imported in the entrypoint of this application to make it work in development mode. Whereas it is
> advisable to remove it before bundling for production, the import it can be kept as long as the version matches the one
> imported in micro-lc.
