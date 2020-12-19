from tf_pose import common
import pandas as pd

class AnalyzeHuman:

    def __init__(self):
        columns = ['frame_name']
        [columns.extend([part.name + '_x', part.name + '_y', part.name + '_score']) for part in common.CocoPart if part != common.CocoPart.Background]
        self._df = pd.DataFrame(columns=columns)

    def get_human_points(self, human, image_width, image_height):
        '''
        human: tf_pose.estimator.Human
        '''
        human_points = {}
        
        for part in common.CocoPart:
            
            if part.value not in human.body_parts.keys():
                continue
            if part == common.CocoPart.Background:
                continue
                
            i = part.value
            points = {
                'x': human.body_parts[i].x * image_width,
                'y': human.body_parts[i].y * image_height,
                'score': human.body_parts[i].score
            }
            
            human_points[part.name] = points
        
        return human_points

    def _create_row(self, frame_name, human_points):
        add_row = {}
        add_row['frame_name'] = frame_name
        for part in common.CocoPart:

            if part == common.CocoPart.Background:
                continue

            part_name = part.name
            if part_name in human_points:
                add_row[part_name+'_x'] = human_points[part_name]['x']
                add_row[part_name+'_y'] = human_points[part_name]['y']
                add_row[part_name+'_score'] = human_points[part_name]['score']
            else:
                add_row[part_name+'_x'] = ''
                add_row[part_name+'_y'] = ''
                add_row[part_name+'_score'] = ''

        return add_row

    def get_and_append_human_points(self, human, frame_name, image_width, image_height):

        human_points = self.get_human_points(human, image_width, image_height)
        row = self._create_row(frame_name, human_points)
        self._df = self._df.append(row, ignore_index=True)
        return self._df

    def save_points(self, path):
        self._df.to_excel(path)
