"use client";

import { useState, useRef, useEffect } from "react";

export default function Home() {
  const [playing, setPlaying] = useState(false);
  const iframeRef = useRef<HTMLIFrameElement>(null);
  const [isFullscreen, setIsFullscreen] = useState(false);

  // Listen for fullscreen change to update button icon
  useEffect(() => {
    if (typeof document !== "undefined") {
      document.addEventListener("fullscreenchange", () => {
        setIsFullscreen(!!document.fullscreenElement);
      });
    }
  }, []);

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
    <main className="min-h-screen bg-gray-900 text-gray-100 p-8">
      <div className="max-w-6xl mx-auto">
        <h1 className="text-4xl font-bold text-center mb-8">
          Cheche Game
        </h1>

        {!playing ? (
          <div className="text-center">
            <p className="text-xl mb-6">
              Click to start playing
            </p>
            <button
              onClick={() => setPlaying(true)}
              className="px-12 py-4 text-2xl bg-pink-500 text-white rounded-xl cursor-pointer shadow-lg shadow-pink-500/40 hover:bg-pink-600 transition-colors"
            >
              Play Now
            </button>
          </div>
        ) : (
          <div className="text-center relative">
            {/* Game container */}
            <div className="w-full max-w-4xl mx-auto mb-4 border-4 border-gray-600 rounded-xl overflow-hidden bg-black shadow-2xl">
              <iframe
                ref={iframeRef}
                src="/game/index.html"
                className="w-full h-[600px] block"
                allow="autoplay; fullscreen; picture-in-picture"
                allowFullScreen
              />
            </div>

            {/* Controls below game */}
            <div className="mt-4 flex justify-center gap-4">
              <button
                onClick={() => setPlaying(false)}
                className="px-8 py-3 bg-gray-600 text-white rounded-lg cursor-pointer hover:bg-gray-700 transition-colors"
              >
                Back to Menu
              </button>

              <button
                onClick={toggleFullscreen}
                title={isFullscreen ? "Exit Fullscreen" : "Go Fullscreen"}
                className={`p-3 text-white rounded-lg cursor-pointer text-xl w-12 h-12 flex items-center justify-center transition-colors ${
                  isFullscreen ? "bg-orange-500 hover:bg-orange-600" : "bg-gray-700 hover:bg-gray-800"
                }`}
              >
                {isFullscreen ? "⤢" : "⤡"}
              </button>

              <button
                onClick={() => window.location.reload()}
                className="px-8 py-3 bg-gray-700 text-gray-300 border border-gray-500 rounded-lg cursor-pointer hover:bg-gray-800 transition-colors"
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
