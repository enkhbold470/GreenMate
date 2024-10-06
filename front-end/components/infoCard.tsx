import React from "react";

interface InfoCardProps {
  icon: React.ReactNode;
  title: string;
  value: string | number;
  prediction?: string;
}

const InfoCard: React.FC<InfoCardProps> = ({
  icon,
  title,
  value,
  prediction,
}) => {
  return (
    <div className="bg-white p-4 rounded-lg shadow-md">
      <div className="flex items-center mb-2">
        {icon}
        <h2 className="ml-2 text-lg font-semibold">{title}</h2>
      </div>
      <p className="text-2xl font-bold mb-1">{value}</p>
      {prediction && <p className="text-sm text-gray-600">{prediction}</p>}
    </div>
  );
};

export default InfoCard;
