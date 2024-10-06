"use client";
import React from "react";
import { Home, BarChart, Settings } from "lucide-react";
import { useRouter } from "next/navigation";
import { useState } from "react";
const navItems = [
  { icon: Home, route: "/" },
  { icon: BarChart, route: "/analytics" },
  // { icon: Bell, route: "/notifications" },
  { icon: Settings, route: "/settings" },
];

const NavItem = ({
  icon: Icon,
  isActive,
  onClick,
}: {
  icon: React.ElementType;
  isActive: boolean;
  onClick: () => void;
}) => (
  <button
    className={`p-2 rounded-full ${
      isActive
        ? "bg-asparagus-600 text-white "
        : "text-asparagus-600 hover:bg-asparagus-700 hover:text-white"
    }`}
    onClick={onClick}
  >
    <Icon size={30} />
  </button>
);

export default function BottomNavbar() {
  const router = useRouter();
  const [activeTab, setActiveTab] = useState("home");

  return (
    <nav className="fixed bottom-4 left-4 right-4 bg-white bg-opacity-80 backdrop-blur-md rounded-full border border-fern_green-200 border-opacity-10 shadow-xl p-2 flex justify-around">
      {navItems.map((item, index) => (
        <NavItem
          key={index}
          icon={item.icon}
          isActive={activeTab === item.route}
          onClick={() => {
            setActiveTab(item.route);
            router.push(item.route);
          }}
        />
      ))}
    </nav>
  );
}
