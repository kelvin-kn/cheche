"use client";

import { useState } from "react";

export default function Home() {
  const [play, setPlay] = useState(false);

  return (
    <main
      style={{
        height: "100vh",
        width: "100vw",
        margin: 0,
        padding: 0,
        background: "#000",
        color: "#fff",
        fontFamily: "sans-serif",
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
      }}
    >
      {!play ? (
        <>
          <h1>Square Jump</h1>
          <button
            onClick={() => setPlay(true)}
            style={{
              padding: "1rem 3rem",
              fontSize: "1.5rem",
              marginTop: "2rem",
              cursor: "pointer",
              background: "#4CAF50",
              border: "none",
              borderRadius: "8px",
              color: "white",
            }}
          >
            Play Game
          </button>
        </>
      ) : (
        <iframe
          src="/game/index.html"
          style={{
            width: "100%",
            height: "100%",
            border: "none",
          }}
          allowFullScreen
        />
      )}
    </main>
  );
}
