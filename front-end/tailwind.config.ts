import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        card: {
          DEFAULT: "hsl(var(--card))",
          foreground: "hsl(var(--card-foreground))",
        },
        popover: {
          DEFAULT: "hsl(var(--popover))",
          foreground: "hsl(var(--popover-foreground))",
        },
        primary: {
          DEFAULT: "hsl(var(--primary))",
          foreground: "hsl(var(--primary-foreground))",
        },
        secondary: {
          DEFAULT: "hsl(var(--secondary))",
          foreground: "hsl(var(--secondary-foreground))",
        },
        muted: {
          DEFAULT: "hsl(var(--muted))",
          foreground: "hsl(var(--muted-foreground))",
        },
        accent: {
          DEFAULT: "hsl(var(--accent))",
          foreground: "hsl(var(--accent-foreground))",
        },
        destructive: {
          DEFAULT: "hsl(var(--destructive))",
          foreground: "hsl(var(--destructive-foreground))",
        },
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        chart: {
          "1": "hsl(var(--chart-1))",
          "2": "hsl(var(--chart-2))",
          "3": "hsl(var(--chart-3))",
          "4": "hsl(var(--chart-4))",
          "5": "hsl(var(--chart-5))",
        },
        asparagus: {
          DEFAULT: "#80B057",
          900: "#1A2411",
          800: "#344822",
          700: "#4E6C33",
          600: "#689044",
          500: "#80B057",
          400: "#9BC07A",
          300: "#B4D09B",
          200: "#CDE0BC",
          100: "#E6EFDE",
        },
        fern_green: {
          DEFAULT: "#5e7d53",
          900: "#131911",
          800: "#263221",
          700: "#394b32",
          600: "#4c6443",
          500: "#5e7d53",
          400: "#7b9f6f",
          300: "#9cb793",
          200: "#bdcfb7",
          100: "#dee7db",
        },
        anti_flash_white: {
          DEFAULT: "#f0f1f5",
          900: "#272b3a",
          800: "#4e5574",
          700: "#7b84a7",
          600: "#b6bace",
          500: "#f0f1f5",
          400: "#f3f4f7",
          300: "#f6f6f9",
          200: "#f9f9fb",
          100: "#fcfcfd",
        },
        white: {
          DEFAULT: "#fcfdfe",
          900: "#19324c",
          800: "#326597",
          700: "#6497cb",
          600: "#afcae4",
          500: "#fcfdfe",
          400: "#fcfdfe",
          300: "#fdfdfe",
          200: "#fdfefe",
          100: "#fefeff",
        },
      },
      borderRadius: {
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)",
      },
    },
  },
  plugins: [],
};
export default config;
