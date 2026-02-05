"use client";

import { useState, useRef } from "react";

export default function Home() {
  const [playing, setPlaying] = useState(false);
  const iframeRef = useRef<HTMLIFrameElement>(null);
  const [isFullscreen, setIsFullscreen] = useState(false);

  // Listen for fullscreen change to update button icon
  if (typeof document !== "undefined") {
    document.addEventListener("fullscreenchange", () => {
      setIsFullscreen(!!document.fullscreenElement);
    });
  }

  const toggleFullscreen = () => {
    if (!iframeRef.current) return;

    const iframe = iframeRef.current;

    if (!isFullscreen) {
      // Request fullscreen on the iframe
      if (iframe.requestFullscreen) {
        iframe.requestFullscreen();
      } else if ((iframe as any).webkitRequestFullscreen) {
        (iframe as any).webkitRequestFullscreen();
      } else if ((iframe as any).mozRequestFullScreen) {
        (iframe as any).mozRequestFullScreen();
      } else if ((iframe as any).msRequestFullscreen) {
        (iframe as any).msRequestFullscreen();
      }
    } else {
      // Exit fullscreen
      if (document.exitFullscreen) {
        document.exitFullscreen();
      } else if ((document as any).webkitExitFullscreen) {
        (document as any).webkitExitFullscreen();
      } else if ((document as any).mozCancelFullScreen) {
        (document as any).mozCancelFullScreen();
      } else if ((document as any).msExitFullscreen) {
        (document as any).msExitFullscreen();
      }
    }
  };

  return (
    <main
      style={{
        minHeight: "100vh",
        background: "#111",
        color: "#eee",
        fontFamily: "Arial, sans-serif",
        padding: "2rem",
        boxSizing: "border-box",
      }}
    >
      <div style={{ maxWidth: "1200px", margin: "0 auto" }}>
        <h1 style={{ textAlign: "center", marginBottom: "2rem" }}>
          Cheche Game
        </h1>

        {!playing ? (
          <div style={{ textAlign: "center" }}>
            <p style={{ fontSize: "1.3rem", marginBottom: "1.5rem" }}>
              Click to start playing
            </p>
            <button
              onClick={() => setPlaying(true)}
              style={{
                padding: "1rem 3rem",
                fontSize: "1.6rem",
                background: "#e91e63",
                color: "white",
                border: "none",
                borderRadius: "12px",
                cursor: "pointer",
                boxShadow: "0 4px 15px rgba(233, 30, 99, 0.4)",
              }}
            >
              Play Now
            </button>
          </div>
        ) : (
          <div style={{ textAlign: "center", position: "relative" }}>
            {/* Game container */}
            <div
              style={{
                width: "100%",
                maxWidth: "900px",
                margin: "0 auto 1rem",
                border: "4px solid #444",
                borderRadius: "12px",
                overflow: "hidden",
                background: "#000",
                boxShadow: "0 10px 30px rgba(0,0,0,0.6)",
              }}
            >
              <iframe
                ref={iframeRef}
                src="/game/index.html"
                style={{
                  width: "100%",
                  height: "600px", // adjust to your game's aspect ratio
                  border: "none",
                  display: "block",
                }}
                allow="autoplay; fullscreen; picture-in-picture"
                allowFullScreen
              />
            </div>

            {/* Controls below game */}
            <div
              style={{
                marginTop: "1rem",
                display: "flex",
                justifyContent: "center",
                gap: "1rem",
              }}
            >
              <button
                onClick={() => setPlaying(false)}
                style={{
                  padding: "0.8rem 2rem",
                  background: "#555",
                  color: "white",
                  border: "none",
                  borderRadius: "8px",
                  cursor: "pointer",
                }}
              >
                Back to Menu
              </button>

              <button
                onClick={toggleFullscreen}
                title={isFullscreen ? "Exit Fullscreen" : "Go Fullscreen"}
                style={{
                  padding: "0.8rem",
                  background: isFullscreen ? "#ff5722" : "#333",
                  color: "white",
                  border: "none",
                  borderRadius: "8px",
                  cursor: "pointer",
                  fontSize: "1.2rem",
                  width: "48px",
                  height: "48px",
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                }}
              >
                {isFullscreen ? "⤢" : "⤡"}{" "}
                {/* Simple icon: expand / compress */}
              </button>

              <button
                onClick={() => window.location.reload()}
                style={{
                  padding: "0.8rem 2rem",
                  background: "#333",
                  color: "#ccc",
                  border: "1px solid #666",
                  borderRadius: "8px",
                  cursor: "pointer",
                }}
              >
                Reload Game
              </button>
            </div>
          </div>
        )}
      </div>
    </main>
  );
}
