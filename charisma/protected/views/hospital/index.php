<?php
$model = new Hospital;
$this->breadcrumbs=array(
	'Hospitals',
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
    $('.search-form').slideToggle('fast');
    return false;
});
$('.search-form form').submit(function(){
    $.fn.yiiGridView.update('hospital-grid', {
        data: $(this).serialize()
    });
    return false;
});
");

?>

<h1>Hospitals</h1>
<hr />

<?php 
$this->beginWidget('zii.widgets.CPortlet', array(
	'htmlOptions'=>array(
		'class'=>''
	)
));
$this->widget('bootstrap.widgets.TbMenu', array(
	'type'=>'pills',
	'items'=>array(
		array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'), 'linkOptions'=>array()),
                array('label'=>'List', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('index'),'active'=>true, 'linkOptions'=>array()),
		array('label'=>'Search', 'icon'=>'icon-search', 'url'=>'#', 'linkOptions'=>array('class'=>'search-button')),
		array('label'=>'Export to PDF', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GeneratePdf'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
		array('label'=>'Export to Excel', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GenerateExcel'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
	),
));
$this->endWidget();
?>



<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->


<?php 

$type = array(
      array('value' => 1, 'text' => 'Analyse'),
      array('value' => 2, 'text' => 'Traitement'),
      array('value' => 3, 'text' => 'Lunette'),
      array('value' => 4, 'text' => 'Pharmacy'),
      
    );

$this->widget('bootstrap.widgets.TbGridView',array(
	'id'=>'hospital-grid',
	'dataProvider'=>$model->search(),
        'type'=>'striped bordered condensed',
        'template'=>'{summary}{pager}{items}{pager}',
	'columns'=>array(
		'id',
		array( 
		  'class' => 'editable.EditableColumn',
            'name' => 'hopitalName',
            'editable' => array(
                'type'      => 'text',
                'url'       => $this->createUrl('Hospital/UpdateBooster'),
                'placement' => 'right',
            )
          ),
	array( 
		'class' => 'editable.EditableColumn',
            'name' => 'address',
            'editable' => array(
                'type'      => 'text',
                'url'       => $this->createUrl('Hospital/UpdateBooster'),
                'placement' => 'right',
            )
          ),
		array( 
                 'class' => 'editable.EditableColumn',
                  'name' => 'type',
                  'editable' => array(
                   'type'     => 'select',
                    'url'      => $this->createUrl('Hospital/updateBooster'),
                   'source'=>$type,
                  ),
          ),
		'iduser',
       array(
            'class'=>'bootstrap.widgets.TbButtonColumn',
			'template' => '{view} {delete}',
			'buttons' => array(
			      'view' => array(
					'label'=> 'View',
					'options'=>array(
						'class'=>'btn btn-small view'
					)
				),	
                             
				'delete' => array(
					'label'=> 'Delete',
					'options'=>array(
						'class'=>'btn btn-small delete'
					)
				)
			),
            'htmlOptions'=>array('style'=>'width: 115px'),
           )
	),
)); ?>
