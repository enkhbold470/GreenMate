import React from "react";
import LoadingSpinner from "./loading";

interface SensorInfoProps {
  icon: React.ElementType;
  label: string;
  value: string | React.ReactNode;
  color: string;
}

export default function SensorInfo({
  icon: Icon,
  label,
  value,
  color,
}: SensorInfoProps) {
  return (
    <div className="bg-white rounded-full p-4 flex items-center space-x-3 shadow-md">
      <div className={`p-2 rounded-full ${color}`}>
        <Icon className="w-6 h-6" />
      </div>
      <div>
        {typeof value === "string" ? (
          <>
            <p className="text-fern_green-700 text-sm">{label}</p>
            <p className="text-fern_green-DEFAULT font-semibold text-sm">
              {value}
            </p>
          </>
        ) : (
          <LoadingSpinner />
        )}
      </div>
    </div>
  );
}