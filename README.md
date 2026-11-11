# Projects

Archivo de prácticas y encargos de Andrea Mangas: documentos de game design, ejercicios de física en Processing, un visualizador 3D en WebGL, piezas de UI/UX y enlaces a vídeos. No es una sola aplicación, sino varias carpetas independientes. El último push es de noviembre de 2024.

## Índice

### Game design (`GDD/`)

- **El Vórtice** — Documento de diseño (`GDD.pdf`), prototipo de pantallas en Adobe XD (`Jueguito.xd`) y un [tráiler en YouTube](https://youtu.be/orpCeq4DoFw) por si no tienes Adobe XD.
- **Elves** — Prueba de game designer (`Andrea_Mangas_Game_Designer_Test.pdf`, `Elfs_Idea.pdf`), mockups, wireframes e ilustraciones (`.ai` y `.png`).

### Física en Processing (`PhysicsProjects-Processing/`)

Sketches para abrir con [Processing](https://processing.org/). Cada carpeta tiene su `.pde` principal y, si hace falta, una carpeta `data/` con imágenes.

- **Box2DPractica** — Coche con ruedas sobre un suelo, usando la librería Box2D de Shiffman (`shiffman.box2d` / JBox2D). Hay que tener esa librería instalada en Processing.
- **Osciladors** — Balón en una pista de baloncesto. Al arrancar eliges `a` (rebote rígido), `b` (cálculo analítico, movimiento armónico) o `c` (muelle / integración numérica) y pulsas Enter.
- **Snake** — Serpiente que sigue el ratón y come un «gusano» que se mueve solo. Hay puntuación y un límite de 60 segundos.
- **forces/Forces_planetes** — Satélite atraído por la Tierra. Opciones `a` (órbita libre), `b` (intento de órbita circular) y `c` (además calcula excentricidad, Rmin y Rmax).
- **forces/Mov_Parabolico** — Tiro parabólico: una bola integrada con gravedad y otra calculada de forma analítica, para comparar trayectorias.

### WebGL (`WEBGL/PracticaWebgl/`)

Visualizador 3D en el navegador con Three.js (`three.min.js`, OrbitControls, OBJLoader). Desde la página puedes cargar los modelos Ninja, Pumpkin, Luigi, Mario y Among Us.

Controles (según la propia página): moverse con W, A, S, D y el ratón; `M`/`N`/`B` cambian el fondo; `F` activa niebla y `C` su color; `R` la rotación; `L` las luces; `+`/`-` la intensidad; `O`/`P` el sentido de giro.

Para verlo, sirve la carpeta `WEBGL/PracticaWebgl/` con un servidor estático local (por ejemplo `python3 -m http.server`) y abre `index.html` en el navegador. No hay `package.json`.

### UI/UX (`UI:UX/`)

- **Cover-ImagineDragonsEvolve** — Portada y contraportada del disco *Evolve* de Imagine Dragons (PDF, PSD e Illustrator).
- **InfografiaKingdomHearts** — Infografía de Kingdom Hearts (`.ai` y `.pdf`).
- **Webs/Local Stocks** — Mockups y documentos de experiencia de usuario en PDF.

### Vídeo (`Video/`)

Enlaces en `Video/VideoProjectLinks.txt`:

- [Animación con After Effects](https://youtu.be/RCun2qcHSQA)
- [Vídeo transmedia](https://youtu.be/QcDA1CvgYU8)

## Cómo abrirlo

No hay un arranque único ni un manifiesto común.

- Processing: instala Processing, abre el `.pde` de cada práctica y pulsa Run. Box2DPractica necesita la librería Box2D.
- WebGL: sirve `WEBGL/PracticaWebgl/` y abre `index.html`.
- PDF, XD, AI y PSD: Adobe Acrobat / XD / Illustrator / Photoshop u otro visor compatible.
- Los vídeos están en YouTube, no en el repo.

El repo pesa alrededor de 100 MB porque incluye modelos 3D, texturas y archivos de diseño.

## Estructura

```
Projects/
├── GDD/                         # El Vórtice, Elves
├── PhysicsProjects-Processing/  # Box2D, osciladores, Snake, fuerzas, tiro parabólico
├── WEBGL/PracticaWebgl/         # visualizador Three.js
├── UI:UX/                       # portada, infografía, Local Stocks
└── Video/VideoProjectLinks.txt
```

## Estado

Colección de trabajos de formación / portfolio, sin mantenimiento reciente (último push en 2024). No había README en el repo.
