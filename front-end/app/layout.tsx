import type { Metadata, Viewport } from "next";
import { Roboto } from "next/font/google";
// import localFont from "next/font/local";
import "./globals.css";
import BottomNavbar from "@/components/navbar/bottom-navbar";
import PlantNotification from "@/components/plant-notification";
const roboto = Roboto({
  subsets: ["latin"],
  weight: ["100", "900"],
});
export const viewport: Viewport = {
  themeColor: "#8FCE00",
};

export const metadata: Metadata = {
  title: "GreenMate",
  description:
    "GreenMate is a platform for managing greenhouses and plants. We are leveraging IoT Sensors with ESP32 and AI to help you grow your plants. Whether you're new to planting or an experienced grower, we've got you covered.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <head>
        <link
          rel="icon"
          type="image/png"
          href="/favicon-48x48.png"
          sizes="48x48"
        />
        <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
        <link rel="shortcut icon" href="/favicon.ico" />
        <link
          rel="apple-touch-icon"
          sizes="180x180"
          href="/apple-touch-icon.png"
        />
        <meta name="apple-mobile-web-app-title" content="GreenMate" />
        <link rel="manifest" href="/site.webmanifest" />
      </head>
      <body className={`${roboto.className} antialiased`}>
        {children}
        <PlantNotification />
        <BottomNavbar />
      </body>
    </html>
  );
}
