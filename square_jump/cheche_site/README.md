# Square Jump Game Website

A modern Next.js website to host and play the Square Jump Godot game.

## Features

- 🎮 **Click-to-Play Interface**: Simple click to start playing the game
- 📱 **Responsive Design**: Works on desktop and mobile devices  
- ⚡ **Fast Loading**: Optimized loading with progress indicators
- 🏆 **Score Display**: Real-time score updates from the game
- 🎨 **Modern UI**: Beautiful gradient design with glassmorphism effects
- 🚀 **Static Export**: Deploy anywhere with static file hosting

## Getting Started

### Install Dependencies
```bash
npm install
```

### Development Mode
```bash
npm run dev
```

Opens at `http://localhost:3000`

### Build for Production
```bash
npm run build
```

### Serve Static Build
```bash
npm run serve
```

Serves the static build at `http://localhost:8080`

## Deployment

### Static Hosting Options
The site builds to static files and can be deployed to:

- **Netlify**: Drag and drop the `out` folder
- **Vercel**: Connect your GitHub repo
- **GitHub Pages**: Use the `out` folder
- **Any static host**: Upload the `out` folder contents

### Build Command
```bash
npm run export
```

This creates an `out` directory with all static files ready for deployment.

## Project Structure

```
cheche_site/
├── src/
│   ├── app/
│   │   ├── page.tsx          # Main game page
│   │   ├── layout.tsx        # Root layout
│   │   └── globals.css       # Global styles
│   └── components/
│       └── GameCanvas.tsx    # Godot game integration
├── public/
│   └── godot/                # Godot game files
│       ├── index.js          # Godot engine loader
│       ├── index.wasm        # WebAssembly engine
│       ├── index.pck         # Game data
│       └── ...               # Other game assets
├── out/                      # Built files (generated)
├── package.json              # Dependencies and scripts
└── next.config.ts            # Next.js configuration
```

## How It Works

1. **Game Loading**: The site dynamically loads the Godot engine JavaScript files
2. **Canvas Integration**: Embeds the game in an HTML5 canvas element
3. **Score Integration**: Captures score updates from the Godot game using the `onGameScore` callback
4. **User Interaction**: Handles click events to focus the game for keyboard input
5. **Static Export**: Generates static HTML/CSS/JS files for deployment anywhere

## Browser Support

- Chrome 80+
- Firefox 72+
- Safari 13+
- Edge 80+

## Game Controls

- Click on the game to focus it
- Use arrow keys or WASD to move
- Jump on platforms and avoid falling!

## License

MIT
