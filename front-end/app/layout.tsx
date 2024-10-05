import type { Metadata, Viewport } from "next";
import { Roboto } from "next/font/google";
// import localFont from "next/font/local";
import "./globals.css";
import BottomNavbar from "@/components/navbar/bottom-navbar";

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
  manifest: "/site.webmanifest",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={`${roboto.className} antialiased`}>
        {children}
        <BottomNavbar />
      </body>
    </html>
  );
}
